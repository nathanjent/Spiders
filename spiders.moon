-- title: Spiders
-- author: Nathan Jent
-- script: moon

FSM=(t)->
 a={}
 for _,v in ipairs t
  {old,event,new,action}=v
  if a[old] == nil
   a[old]={}
  a[old][event]=:new,:action
 a

mulvec=(p,s)->
 x:p.x*s,y:p.y*s

addvec=(p0,p1)->
 x:p0.x+p1.x,y:p0.y+p1.y

ptOnCurve=(p0,p1,p2,p3,t)->
 u=1-t
 addvec(
  addvec mulvec(p0,u*u*u),mulvec(p1,3*u*u*t)
  addvec mulvec(p2,3*u*t*t),mulvec(p3,t*t*t)
 )

bcurve=(p0,p1,p2,p3,color,spacing)->
 for t=0,1,spacing
  pt=ptOnCurve p0,p1,p2,p3,t
  pix pt.x,pt.y,color

spd=
 x:15
 y:1
 web:{
  {20,10}
  {20,10}
  {20,30}
 }
 state:"idle"
 fsm:FSM{
  {"idle","walk","walking",()->print("start walking",10,10)}
  {"walking","walk","walking",()->print("I'm going.",20,10)}
 }

update=(t)->
 amp=20
 freq=1/800
 spd.y=40+amp*math.sin(t*freq)
 spd.x+=math.cos(t*freq*1.2)/4
 spd.web[2][2]=spd.web[1][2]+spd.y/4
 spd.web[3][2]=spd.web[1][2]+spd.y/2
 print "x: #{spd.x}, y: #{spd.y}",0,0

 a=spd.fsm[spd.state]["walk"]
 a.action()
 b=spd.fsm[spd.state]["walk"]
 b.action()

draw=(t)->
 bcurve(
  {x:spd.web[1][1],y:spd.web[1][2]},
  {x:spd.web[2][1],y:spd.web[2][2]},
  {x:spd.web[3][1],y:spd.web[3][2]},
  {x:spd.x+8,y:spd.y},
  10,
  0.02
 )
 spr 272,spd.x,spd.y,0,1,0,0,2,2

export TIC=->
 cls 0
 t=time()
 update t
 draw t
 
-- <SPRITES>
-- 001:000ee000d0eeee0d0deeeed0d00ee00d00e22e000d0ee0d0d0d00d0d00000000
-- 016:00d000ee00d00eef00d0eef100d0eeff00d0effed00defff0d00eef100dddeef
-- 017:ee000d00fee00d001fee0d00ffee0d00effe0d00fffed00d1fee00d0feeddd00
-- 032:000000ee000ddee200d00eee0d000e2ed000d0ee000d00e0000d0000000d0000
-- 033:ee0000002eedd000eee00d00e2e000d0ee0d000d0e00d0000000d0000000d000
-- 048:0000000000000000001fef100fffffffeffddfdf0ededded0d0edefdd00d0000
-- 049:00000000000000000eee0000e2e2e000fedee000fdedee00d0d0d00000d00d00
-- 064:0000000000000000001fef100fffffffeffddffd0edededd0d0eede0d0000d00
-- 065:00000000000000000eee0000e2e2e000feede000fedede00dddd0d00000000d0
-- 080:0000000000000000001fef100fffffffefffdfdf0eeddded00deeddd0d0d00d0
-- 081:00000000000000000eee0000e2e2e000fdeee000dddeee000ddd000000d0d000
-- </SPRITES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

