#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Twist
import curses

# Map from key character to twist message
key_mapping = { 'w': [0, 1], 'a': [1, 0], 's': [0, -1], 'd': [-1, 0] }

def key_to_twist(ch):
    if ch in key_mapping:
        vels = key_mapping[ch]
    else:
        vels = [0, 0]
    return vels

def main(stdscr):
    rospy.init_node('teleop_key')

    pub = rospy.Publisher('cmd_vel', Twist, queue_size=1)

    rate = rospy.Rate(10)
    move_cmd = Twist()

    while not rospy.is_shutdown():
        ch = stdscr.getch()
        
        if ch == -1:
            move_cmd.linear.x = 0.0
            move_cmd.angular.z = 0.0
        else:
            ch = chr(ch)
            vels = key_to_twist(ch)
            move_cmd.linear.x = vels[1]
            move_cmd.angular.z = vels[0]
        pub.publish(move_cmd)
        rate.sleep()

if __name__ == "__main__":
    curses.wrapper(main)
