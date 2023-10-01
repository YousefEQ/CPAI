start([3,3,right,0,0]).
goal([0,0,right,3,3]).

legal(LionL,WildL,LionR,WildR) :-
% is this state a legal one?
WildL>=0, LionL>=0, WildR>=0, LionR>=0,
(WildL>=LionL ; WildL=0),
(WildR>=LionR ; WildR=0).

% Possible moves:
move([LionL,WildL,right,LionR,WildR],[LionL,WildL2,right,LionR,WildR2]):-
% Two hens Cross left to right.
WildR2 is WildR+2,
WildL2 is WildL-2,
legal(LionL,WildL2,LionR,WildR2).

move([LionL,WildL,right,LionR,WildR],[LionL2,WildL,right,LionR2,WildR]):-
% Two foxes Cross left to right.
LionR2 is LionR+2,
LionL2 is LionL-2,
legal(LionL2,WildL,LionR2,WildR).

move([LionL,WildL,right,LionR,WildR],[LionL2,WildL2,right,LionR2,WildR2]):-
% One hen and one fox Cross left to right.
LionR2 is LionR+1,
LionL2 is LionL-1,
WildR2 is WildR+1,
WildL2 is WildL-1,
legal(LionL2,WildL2,LionR2,WildR2).

move([LionL,WildL,right,LionR,WildR],[LionL,WildL2,right,LionR,WildR2]):-
% One hen Crosses left to right.
WildR2 is WildR+1,
WildL2 is WildL-1,
legal(LionL,WildL2,LionR,WildR2).

move([LionL,WildL,right,LionR,WildR],[LionL2,WildL,right,LionR2,WildR]):-
% One fox Crosses left to right.
LionR2 is LionR+1,
LionL2 is LionL-1,
legal(LionL2,WildL,LionR2,WildR).

find_optimal_solution(Start,Start,_,[Start]) :- goal(Start).
find_optimal_solution(Start,Current,Visited,[Current|Rest]) :-
move(Current,Next),
not(member(Next,Visited)),
find_optimal_solution(Start,Next,[Next|Visited],Rest).

print_optimal_solution([]) :- write("Solution Found!").
print_optimal_solution([Current|Rest]) :-
write("Move: "), write(Current), nl,
print_optimal_solution(Rest).

run :-
start(Start),
find_optimal_solution(Start,Start,[Start],Optimal_solution),
print_optimal_solution(Optimal_solution).
