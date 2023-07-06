#!/home/hilman/i2dl/bin/python

import rospy
from geometry_msgs.msg import Twist
from pynput import keyboard

# Define the speeds
linear_speed = 0.5
angular_speed = 0.5

# Define the Twist message
twist = Twist()

# Define the publisher
pub = rospy.Publisher('turtle1/cmd_vel', Twist, queue_size=1)

def on_press(key):
    if key == keyboard.Key.up or key.char == 'w':
        # Move forward
        twist.linear.x = linear_speed
        twist.angular.z = 0.0
    elif key == keyboard.Key.down or key.char == 's':
        # Move backwards
        twist.linear.x = -linear_speed
        twist.angular.z = 0.0
    elif key == keyboard.Key.left or key.char == 'a':
        # Turn left
        twist.linear.x = 0.0
        twist.angular.z = angular_speed
    elif key == keyboard.Key.right or key.char == 'd':
        # Turn right
        twist.linear.x = 0.0
        twist.angular.z = -angular_speed

def on_release(key):
    # Stop movement when key is released
    twist.linear.x = 0.0
    twist.angular.z = 0.0

    # Stop listener when 'esc' is pressed
    if key == keyboard.Key.esc:
        return False

if __name__=="__main__":
    rospy.init_node('turtlebot_teleop')

    # Set up keyboard listener
    with keyboard.Listener(on_press=on_press, on_release=on_release) as listener:
        while not rospy.is_shutdown():
            pub.publish(twist)
            rospy.Rate(10).sleep()  # 10Hz