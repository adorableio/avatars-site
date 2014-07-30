module.exports = {
  KEY_0         : 48
  KEY_1         : 49
  KEY_2         : 50
  KEY_3         : 51
  KEY_4         : 52
  KEY_5         : 53
  KEY_6         : 54
  KEY_7         : 55
  KEY_8         : 56
  KEY_9         : 57
  KEY_BACKSPACE : 8
  KEY_TAB       : 9
  KEY_LEFT      : 37
  KEY_UP        : 38
  KEY_RIGHT     : 39
  KEY_DOWN      : 40
  isNumber: (code) ->
    for i in [@KEY_0..@KEY_9]
      return true if code == i
    return false
}
