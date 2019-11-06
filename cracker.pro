%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% maf0288
% COSC: 4430
% Assignment: 5
% Note: I am not the author of this code and am only submitting my commented
% version of the available solution in my reference. I did not understand how
% to complete this on my own.
% REFERENCED SOURE: https://rosettacode.org/wiki/I.Q._Puzzle#Prolog
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- use_module(library(lambda)).
 
solve :-
	solve(MovA),
	writeln('=======solution run======='),
	show(MovA).
 
% Solution
%
solve(MovA) :-
	step([1], [2,3,4,5,6,7,8,9,10,11,12,13,14,15], [], MovA).

step(_, [_], List, Moves) :-
	reverse(List, Moves).

% V - Vacant, N - No Vacancy, List - List of moves completed,
% Moves - total moves
step(V, N, List, Moves) :-
	select(S, N, Oc1),
	select(O, Oc1, Oc2),
	select(E, V, F1),
	move(S, O, E),
	step([S, O | F1], [E | Oc2], [move(S,O,E) | List], Moves).
%

% moveset
%
move(S,2,E) :- member([S,E], [[1,4], [4,1]]).
move(S,3,E) :- member([S,E], [[1,6], [6,1]]).
move(S,4,E) :- member([S,E], [[2,7], [7,2]]).
move(S,5,E) :- member([S,E], [[2,9], [9,2]]).
move(S,5,E) :- member([S,E], [[3,8], [8,3]]).
move(S,6,E) :- member([S,E], [[3,10], [10,3]]).
move(S,5,E) :- member([S,E], [[4,6], [6,4]]).
move(S,7,E) :- member([S,E], [[4,11], [11,4]]).
move(S,8,E) :- member([S,E], [[4,13], [13,4]]).
move(S,8,E) :- member([S,E], [[5,12], [12,5]]).
move(S,9,E) :- member([S,E], [[5,14], [14,5]]).
move(S,9,E) :- member([S,E], [[6,13], [13,6]]).
move(S,10,E) :- member([S,E], [[6,15], [15,6]]).
move(S,8,E) :- member([S,E], [[9,7], [7,9]]).
move(S,9,E) :- member([S,E], [[10,8], [8,10]]).
move(S,12,E) :- member([S,E], [[11,13], [13,11]]).
move(S,13,E) :- member([S,E], [[12,14], [14,12]]).
move(S,14,E) :- member([S,E], [[15,13], [13,15]]).
 
 
% shows Solution
%
show(Solution) :-
	show(Solution, [1]).

% Here is where the lambda implementation is important
% This allows the use of a postfix within the maplist
% Allowing the list to be displayed with the according
% I = . and I = x and the list the list that was output
% maplist({PostFix}/[In,Out]>>atom_concat(In,PostFix,Out), ListIn, ListOut).
show([], V) :-
	numlist(1,15, List),
	maplist(\X^I^(member(X, V) -> I = .; I = x),List, [I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n~n', [I11,I12,I13,I14,I15]),
	writeln("=======run complete=======).
 
 
show([move(Start, Middle, End) | Tail], V) :-
	numlist(1,15, List),
	maplist(\X^I^(member(X, V) -> I = .; I = x),
		List,
		[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n~n', [I11,I12,I13,I14,I15]),
	select(End, V, F1),
	show(Tail,  [Start, Middle | F1]).