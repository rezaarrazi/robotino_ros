#!/usr/bin/env python
import requests 
import sys
import rospy
import json
from geometry_msgs.msg import Twist

# api-endpoint 
URL = "http://127.0.0.1/data/omnidrive"
PARAMS = {'sid':'robotino_rest_node'} 

def callback(data):
	rospy.loginfo("%f %f %f" % (data.linear.x, data.linear.y, data.angular.z) )
	pdata = [data.linear.x, data.linear.y, data.angular.z]
	try:
		rospy.loginfo('Send data: [x: {}, y: {}, omega: {}]'.format(pdata[0], pdata[1], pdata[2]))
		r = requests.post(url = URL, params = PARAMS, data = json.dumps(pdata) )
		if r.status_code != requests.codes.ok:
			rospy.logwarn("post to %s with params %s failed", URL, PARAMS)
	except requests.exceptions.RequestException as e:
		rospy.logerr("%s", e)
		pass

def listener():
	rospy.init_node('robotino_omnidrive', anonymous=True)
	rospy.Subscriber("/cmd_vel", Twist, callback)
	rospy.spin()

if __name__ == '__main__':
	myargv = rospy.myargv(argv=sys.argv)
	if len(myargv)>1:
		URL = URL.replace("127.0.0.1",myargv[1])
	print("connecting to: ",URL)
	try:
		listener()
	except rospy.ROSInterruptException:
		pass