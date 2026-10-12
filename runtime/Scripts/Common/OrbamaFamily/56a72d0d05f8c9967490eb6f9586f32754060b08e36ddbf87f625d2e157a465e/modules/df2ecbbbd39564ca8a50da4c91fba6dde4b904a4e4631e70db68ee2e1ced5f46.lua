return function(require)
return {name='TwistedFate',profiles={normal=true,classic=true},
 Create=function(context)return require('tf.app').new(context)end}

end
