safe_move(LionL,WildL,LionR,WildR) :-
% is this state a legal one?
WildL>=0, LionL>=0, WildR>=0, LionR>=0,%cant be less than zero
(WildL>=LionL ; WildL=0),
% ON THE LEFT:
%either the wildebeests are more than the lions
%or the wildebeests are zero
(WildR>=LionR ; WildR=0).
% ON THE RIGHT:
%either the wildebeests are more than the lions
%or the wildebeests are zero

% Possible moves:
move([LL,WildL,left,LR,WildR],[LL,WildL2,right,LR,WildR2]):-
% Two WILDEBEEST Cross left to right.
WildR2 is WildR+2,
WildL2 is WildL-2,
safe_move(LL,WildL2,LR,WildR2).

move([LionL,WL,left,LionR,WR],[LionL2,WL,right,LionR2,WR]):-
% Two LIONS Cross left to right.
LionR2 is LionR+2,
LionL2 is LionL-2,
safe_move(LionL2,WL,LionR2,WR).

move([LionL,WildL,left,LionR,WildR],[LionL2,WildL2,right,LionR2,WildR2]):-
% One WILDEBEEST and one LION Cross left to right.
LionR2 is LionR+1,
LionL2 is LionL-1,
WildR2 is WildR+1,
WildL2 is WildL-1,
safe_move(LionL2,WildL2,LionR2,WildR2).

move([LionL,WildL,left,LionR,WildR],[LionL,WildL2,right,LionR,WildR2]):-
% One WILDEBEEST Crosses left to right.
WildR2 is WildR+1,
WildL2 is WildL-1,
safe_move(LionL,WildL2,LionR,WildR2).

move([LionL,WildL,left,LionR,WildR],[LionL2,WildL,right,LionR2,WildR]):-
% One LION Crosses left to right.
LionR2 is LionR+1,
LionL2 is LionL-1,
safe_move(LionL2,WildL,LionR2,WildR).

move([LionL,WildL,right,LionR,WildR],[LionL,WildL2,left,LionR,WildR2]):-
% Two WILDEBEEST Cross right to left.
WildR2 is WildR-2,
WildL2 is WildL+2,
safe_move(LionL,WildL2,LionR,WildR2).

move([LionL,WildL,right,LionR,WildR],[LionL2,WildL,left,LionR2,WildR]):-
% Two LIONS Cross right to left.
LionR2 is LionR-2,
LionL2 is LionL+2,
safe_move(LionL2,WildL,LionR2,WildR).
move([LionL,WildL,right,LionR,WildR],[LionL2,WildL2,left,LionR2,WildR2]):-
% One WILDEBEEST and one LION Cross right to left.
LionR2 is LionR-1,
LionL2 is LionL+1,
WildR2 is WildR-1,
WildL2 is WildL+1,
safe_move(LionL2,WildL2,LionR2,WildR2).

move([LionL,WildL,right,LionR,WildR],[LionL,WildL2,left,LionR,WildR2]):-
% One WILDEBEEST Crosses right to left.
WildR2 is WildR-1,
WildL2 is WildL+1,
safe_move(LionL,WildL2,LionR,WildR2).

move([LionL,WildL,right,LionR,WildR],[LionL2,WildL,left,LionR2,WildR]):-
% One LION Crosses right to left.
LionR2 is LionR-1,
LionL2 is LionL+1,
safe_move(LionL2,WildL,LionR2,WildR).
% Recursive call to solve the problem
% path([initial],[final],visited,list_of_steps_taken)
path([LionL1,WildL1,B1,LionR1,WildR1],[LionL2,WildL2,B2,LionR2,WildR2],Visited,MovesList) :-
%move([last],[next], not(visited already), list_of_steps_taken)
move([LionL1,WildL1,B1,LionR1,WildR1],[LionL3,WildL3,B3,LionR3,WildR3]),
not(member([LionL3,WildL3,B3,LionR3,WildR3],Visited)),
%and move
path([LionL3,WildL3,B3,LionR3,WildR3],[LionL2,WildL2,B2,LionR2,WildR2],[[LionL3,WildL3,B3,LionR3,WildR3]|Visited],[[[LionL3,WildL3,B3,LionR3,WildR3],[LionL1,WildL1,B1,LionR1,WildR1]] | MovesList]).

% Solution found
path([LionL,WildL,B,LionR,WildR],[LionL,WildL,B,LionR,WildR],_,MovesList):-
output(MovesList).
% Printing
output([]) :- nl.
output([[A,B]|MovesList]) :-
write(B), write(' -> '), write(A), nl,
output(MovesList).

% Find the solution for the wildebeest and lion problem
find :-
path([3,3,left,0,0],[0,0,right,3,3],[[3,3,left,0,0]],[]).
