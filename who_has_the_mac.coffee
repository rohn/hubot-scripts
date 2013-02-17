# Description
#   Find out who has the mobile coding/debugging kit (MacBook Pro + iPad).
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot who has the Mac - Find out who has the MacBook Pro + iPad
#   hubot i have the Mac - Set that you have the Mac
#
# Notes:
#   TODO:
#   add this command:
#       hubot i gave the Mac to <user> - Set that you don't have the Mac and who you gave it to
#
# Author:
#   rohn

module.exports = (robot) ->

  # Find the user by user name from hubot's brain.
  #
  # name - A full or partial name match.
  #
  # Returns a user object if a single user is found, an array of users if more
  # than one user matched the name or false if no user is found.
  findUser = (name) ->
    users = robot.brain.usersForFuzzyName name
    if users.length is 1
      users[0]
    else if users.length > 1
      users
    else
      false


  robot.respond /who has the Mac/i, (msg) ->
    theReply = " has the MacBook Pro\n"

    for own key, user of robot.brain.users
      if(user.hasMac)
        theReply = user.name + theReply

    msg.send theReply


  robot.respond /i have the Mac/i, (msg) ->
    for own key, user of robot.brain.users
      if(user.hasMac)
        user.hasMac = hasMac: false, timestamp: new Date

    name = msg.message.user.name
    user = findUser name

    if typeof user is 'object'
      user.hasMac = hasMac: true, timestamp: new Date
      msg.reply "Okay, I acknowledge that you have the MacBook Pro"
    else if typeof user.length > 1
      msg.send "I found #{user.length} people named #{name}"
    else
      msg.send "I have never met #{name}"
