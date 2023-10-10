% move( State1, Move, State2): making Move in State1 results in State2;
%    a state is represented by a term:
%    state( MonkeyHorizontal, MonkeyVertical, BoxPosition, HasBanana)

move( state( middle, onbox, middle, hasnot),   % Before move
      grasp,                                   % Grasp banana
      state( middle, onbox, middle, has) ).    % After move

move( state( P, onfloor, P, H),
      climb,                                   % Climb box
      state( P, onbox, P, H) ).

move( state( P1, onfloor, P1, H),
      push( P1, P2),                           % Push box from P1 to P2
      state( P2, onfloor, P2, H) ).

move( state( P1, onfloor, B, H),
      walk( P1, P2),                           % Walk from P1 to P2
      state( P2, onfloor, B, H) ).

% canget( State1, State2, StepsSoFar, Steps)
canget( state(_, _, _, has), state(_, _, _, has), [], Steps).  % Base case: goal state is reached, return the list of steps

canget(State1, _, _, _) :-
  move(State1, Move, State3),
  \+ member(Move, StepsSoFar),
  (State3 = State2, reverse([Move|StepsSoFar], Steps) ;
   canget(State3, State2, [Move|StepsSoFar], Steps)).

