%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%% 




%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% this predicate to return list with all teams with input country 


get_list_all_teams_with_country(Country, Teams) :-
    collect_teams_by_country(Country, [], Teams).

collect_teams_by_country(Country, TempList, AnswerList) :-
    team(Name, Country, _), % must be team and _ means not important for me  and here filter based on iput  countery 
    \+ member(Name, TempList), %  here to prevent duplicates
    collect_teams_by_country(Country, [Name | TempList], AnswerList).

collect_teams_by_country(_, AnswerList, AnswerList).

% count the number of elements in a list
count(List, Result) :-
    count(List, 0, Result).



% this is base case when all items in list added in acc list so 2 are same %
count([], Accumalitive_Count,Accumalitive_Count ).

% here ignore first element in list and add 1 to prev count %
count([_|Tail], Acc, Result) :-
    NewAcc is Acc + 1,
    count(Tail, NewAcc, Result).


% this is predicate which do the need  by using 2 predicates %

team_count_by_country(Country, Count) :-
    get_list_all_teams_with_country(Country, Teams),
    count(Teams, Count).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 7 %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
