lion(1).
lion(2).
lion(3).
wildebeest(1).
wildebeest(2).
wildebeest(3).

cross(Lion,Wildebeest,Boat):- lion(Lion),wildebeest(Wildebeest), Lion /= Wildebeest.
init_lions(T):- T=[1,2,3].
init_wildebeest(T):- T=[1,2,3].
right_side(lions,T):- init_lions(T).
right_side(wildebeest,T):- init_wildebeest(T).
left_side(lions,T).
left_side(wildebeest,T).
b_Cross(Lion,Wildebeest,Boat):- cross(Lion,Wildebeest,Boat), right_side(lions,T1), delete(Lion, T1, T2), right_side(wildebeest,T3), delete(Wildebeest, T3, T4).
b_Return(Lion, Wildebeest, Boat) :- cross(Lion,Wildebeest,Boat), left_side(lions, T1), append([Lion], T1, T2), left_side(wildebeest, T3), append([Wildebeest], T3, T4).
all_crossed:- right_side(lions,T), T=[], right_side(wildebeest,T2), T2=[].
success :- all_crossed.
