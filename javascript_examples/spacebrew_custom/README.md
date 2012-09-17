created by: Quin Kennedy at the LAB at Rockwell Group
date: 9/17/2012

brief:
This is a customizable javascript spacebrew client. You can define and share custom functions to handle and send messages.

variables:
data - a variable provided for you to easily store custom information between callbacks. This defaults to a map. Since it is a javascript variable, it can be whatever you want. Remember to initialize your properties, attributes, and keys before use!

prevString, prevBoolean, prevRange - the previously-received values for each respective subscriber. These get updated after the respective functions are called.


functions(o - a function designed for you to override, u - a utility function):
o - init() - a function that gets run during the 'onOpen' event of the websocket. This function gets run after the introductory text is printed out, so you can provide custom text to describe what your customized page does.

o - onBoolean(value), onRange(value), onString(value) - a group of functions that are called when data is received on the respective subscriber. the first parameter will contain the actual value received by that subscriber. If you return a map with either 'range', 'string', or 'boolean' keys containing a value, a message will automatically be sent on the respective publisher. For example if you have "return {string:'done processing',boolean:true};" in your function, then a message will be sent on the string and boolean publishers.

u - sendMessage(type, value) - A function for you to explicitly send a value via some publisher. type can be "string","range", or "boolean" and whatever is provided as the second argument will be the contents of the message published.

u - getLink() - returns a url that you can copy and paste to easily re-create the current custom functionality. This function dumps out the current 'override-able' functions (init, onBoolean/String/Range)
