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

%superstates
superstate(init,boot_hw).
superstate(init,senchk).
superstate(init,ready).
superstate(init,psichk).
superstate(init,tchk).
superstate(monitoring,monidle).
superstate(monitoring,regulate_environment).
superstate(monitoring,lockdown).
superstate(lockdown,prep_vpurge).
superstate(lockdown,alt_temp).
superstate(lcokdown,alt_psi).
superstate(lockdown,safe_status).
superstate(lockdown,risk_assess).

%initial states
initial_state(boot_hw,init).
initial_state(monidle,monitoring).
initial_state(prep_vpurge,lockdown).


%transitions from 2.5
transition(safe_shutdown,final,killswitch_triggered,null,null,null).
transition(dormant,final,killswitch_triggered,null,null,null).
transition(init,final,killswitch_triggered,null,null,null).
transition(idle,final,killswitch_triggered,null,null,null).
transition(error_diagnosis,final,killswitch_triggered,null,null,null).
transition(monitoring,final,killswitch_triggered,null,null,null).

%safe_shutdown
transition(safe_shutdown,dormant,sleep,null,null,null).

%init
transition(init,idle,init_ok,null,null,null).
transition(init,error_diagnosis,init_crash,null,init_err_msg,null).

%inside init
transition(boot_hw,senchk,hwok,null,null,null).
transition(senchk,tchk,sen_ok,null,null,null).
transition(tchk,psichk,t_ok,null,null,null).
transition(psichk,ready,psi_ok,null,null,null).

%error_diagnosis
transition(error_diagnosis,idle,idle_rescue,null,null,null).
transition(error_diagnosis,monitoring,moni_rescue,null,null,null).
transition(error_diagnosis,init,retry_init,'retry<=3','retry++',null).
transition(error_diagnosis,safe_shutdown,shutdown,'retry>3','retry=0',null).

%idle
transition(idle,monitoring,begin_monitoring,null,null,null).
transition(idle,error_diagnosis,idle_crash,idle_err_msg,null,null).

%monitoring
transition(monitoring,error_diagnosis,monitor_crash,'lockdown=false',moni_err_msg,null).
%inside monitoring
transition(monidle,regulate_environment,no_contagion,null,null,null).
transition(regulate_environment,monidle,after_100ms,null,null,null).
transition(monidle,monidle,verify_contagion,null,set_contagion,null).
transition(monidle,lockdown,contagion_alert,null,faculty_crit_mesg,'inlockdown=true').
transition(lockdown,monidle,purge_succ,null,'inlockdown=false',null).
transition(prep_vpurge,alt_temp,initiate_purge,null,lock_doors,null).
transition(prep_vpurge,alt_psi,initiate_purge,null,lock_doors,null).
transition(alt_temp,alt_temp,perform_alteration,null,null,null).
transition(alt_psi,alt_psi,perform_alteration,null,null,null).
transition(alt_temp,risk_assess,toyc_comp,null,null,null).
transition(alt_psi,risk_assess,psiyc_comp,null,null,null).
transition(risk_assess,risk_assess,evaluate_risk,null,set_risk,null).
transition(risk_assess,prep_vpurge,risk_action,'risk>1',null,null).
transition(risk_assess,safe_status,risk_action,'risk<=1',unlock_doors,null).
transition(safe_status,exit,null,null,null,null).













