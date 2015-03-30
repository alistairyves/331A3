%facts
%transition(state1,state2,event,guard,action1,action2).

%states
state(safe_shutdown).
state(init).
state(boot_hw).
state(senchk).
state(tchk).
state(psichk).
state(ready).
state(dormant).
state(error_diagnosis).
state(idle).
state(monitoring).
state(monidle).
state(regulate_environment).
state(lockdown).
state(prep_vpurge).
state(alt_temp).
state(alt_psi).
state(safe_status).
state(risk_assess).

%transitions from 2.5
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
transition(init,error_diagnosis,init_crash,_,_,_).
transition(init,error_diagnosis,init_err_msg,_,_,_).

%error_diagnosis
transition(error_diagnosis,idle,idle_rescue,_,_,_).
transition(error_diagnosis,monitoring,moni_rescue,_,_,_).

%idle
transition(idle,monitoring,begin_monitoring,_,_,_).
transition(idle,error_diagnosis,idle_crash,_,_,_).
transition(idle,error_diagnosis,idle_err_msg,_,_,_).

%monitoring
transition(monitoring,error_diagnosis,monitor_crash,'lockdown=false',_,_).
transition(monitoring,error_diagnosis,moni_err_msg,_,_,_).


