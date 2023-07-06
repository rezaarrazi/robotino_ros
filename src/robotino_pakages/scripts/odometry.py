#!/usr/bin/env python

import requests 
import sys
import rospy
import tf
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Point, Pose, Quaternion, Twist, Vector3

# api-endpoint 
URL = "http://127.0.0.1/data/odometry"
PARAMS = {'sid':'robotino_rest_node'} 

def talker():
  odomPub = rospy.Publisher('/odom', Odometry, queue_size=50)
  odom_broadcaster = tf.TransformBroadcaster()
  rospy.init_node('robotino_odom_publisher', anonymous=True)
  rate = rospy.Rate(10) # 10hz
  while not rospy.is_shutdown():
    try:
      r = requests.get(url = URL, params = PARAMS)
      if r.status_code == requests.codes.ok:
        data = r.json() 
        rospy.loginfo(data)
        current_time = rospy.Time.now()
        [x, y, w, vx, vy, vw] = data[0:6]

        odom_quat = tf.transformations.quaternion_from_euler(0, 0, w)
        odom_broadcaster.sendTransform((x, y, 0.), odom_quat, current_time, "base_footprint", "odom")
        odom = Odometry()
        odom.header.stamp = current_time
        odom.header.frame_id = "odom"
        odom.pose.pose = Pose(Point(x, y, 0.), Quaternion(*odom_quat))
        odom.child_frame_id = "base_footprint"
        odom.twist.twist = Twist(Vector3(vx, vy, 0), Vector3(0, 0, vw))
        odomPub.publish(odom)
      else:
        rospy.logwarn("get from %s with params %s failed", URL, PARAMS)
    except requests.exceptions.RequestException as e:
      rospy.logerr("%s", e)
      pass
    rate.sleep()

if __name__ == '__main__':
  myargv = rospy.myargv(argv=sys.argv)
  if len(myargv)>1:
    URL = URL.replace("127.0.0.1",myargv[1])
  print("connecting to: ",URL)
  try:
    talker()
  except rospy.ROSInterruptException:
    pass