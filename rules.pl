%is_loop(Event, Guard).
%succeeds by finding a loop edge. We assume that an edge
%can be represented by a non-null event-guard pair.
is_loop(Event,Guard):-
	transition(State,State,Event,Guard,_,_).
%all_loops(Set).
%succeeds by returning a set of all loop edges
all_loops(Set):-
	findall(loop(Event,Guard),is_loop(Event,Guard),L),
	list_to_set(L,Set).
%is_edge(Event, Guard).% succeeds by finding an edge.
is_edge(Event,Guard):-
	transition(_,_,Event,Guard,_,_).
% size(Length).% succeeds by returning the size of the entire EFSM (given
% by the number of its edges).
size(Length):-
	findall(transition(State1,State2,Event,Guard,_,_),transition(State1,State2,Event,Guard,_,_),L),
	length(L,Length).
%is_link(Event, Guard).%succeeds by finding a link edge.
is_link(Event,Guard):-
	transition(_,_,Event,Guard,_,_).
%all_superstates(Set).% succeeds by finding all superstates in the EFSM.
all_superstates(Set):-
	findall(State,superstate(State,_),L),
	list_to_set(L,Set).
ancestor(Ancestor, Descendant).% is a utility rule that succeeds by returning an ancestor
%to a given state.
inheritss_transitions(State, List). succeeds by returning all transitions inherited
by a given state.
all_states(L). %succeeds by returning a list of all states.
all_init_states(L). % succeeds by returning a list of all starting states.
get_starting_state(State).% succeeds by returning the top-level starting state.
state_is_reflexive(State).% succeeds is State is reflexive.
graph_is_reflexive(Set).% succeeds if the entire EFSM is reflexive.
get_guards(Ret). %succeeds by returning a set of all guards.
get_events(Ret). %succeeds by returning a set of all events.
get_actions(Ret).% succeeds by returning a set of all actions.
get_only_guarded(Ret).% succeeds by returning state pairs that are associated by guards only.
legal_events_of(State, L). %succeeds by returning all legal event-guard pairs
