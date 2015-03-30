%facts
%transition(state1,state2,event,guard,action1,action2).

transition(safe_shutdown,final,killswitch_triggered,_,_,_).
transition(dormant,final,killswitch_triggered,_,_,_).
transition(init,final,killswitch_triggered,_,_,_).
transition(idle,final,killswitch_triggered,_,_,_).
transition(error_diagnosis,final,killswitch_triggered,_,_,_).
transition(monitoring,final,killswitch_triggered,_,_,_).

%safe_shutdown
transition(safe_shutdown,dormant,sleep,_,_,_).

%init
transition(init,idle,init_ok,_,_,_).

