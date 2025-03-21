%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%% 


players_in_team(Team, Players) :-        
    players_names(Team, [], Players).   % [] is an empty Acc to append players in

% recursive case 
players_names(Team, Acc, Players):-  
    player(Name, Team, _),              % getting the name of the player from the player structure
    \+ member(Name, Acc),               % if it is not exist in the Acc list  
    append(Acc, [Name], NewAcc),        % then add the player name to the list 
    players_names(Team, NewAcc, Players). % recall the function again to get another player

% base case 
players_names(_, Acc, Acc).             % return list of players stored in the Acc 

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
most_successful_team(Team) :-
    team(Team,_ , Num_of_winning_times_to_this_team),            % this line means select one team where 
    \+ (team(_, _, Num_of_winning_times_to_this_team_to_other_teams),      %   compare to all ather teams number of  winning is largest 
        Num_of_winning_times_to_this_team_to_other_teams > Num_of_winning_times_to_this_team).  % why using not  it checks every other team but if i make it ,  and it will take one random %

%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this is similar to task 1 %
matches_of_team(Team, Matches) :-        
    matches_list(Team, [], Matches).   % empty Acc to append matches in

% recursive case 1
matches_list(Team, Acc, Matches):-  
    match(Team, Opponent, G1, G2),      % getting match where Team is Team1
    \+ member((Team, Opponent, G1, G2), Acc),  % if it is not exist in the Acc list  
    append(Acc, [(Team, Opponent, G1, G2)], NewAcc),  % then add the match to the list 
    matches_list(Team, NewAcc, Matches). % recall the function again to get another match

% recursive case 2
matches_list(Team, Acc, Matches):-  
    match(Opponent, Team, G1, G2),      % getting match where Team is Team2
    \+ member((Opponent, Team, G1, G2), Acc),  % if it is not exist in the Acc list  
    append(Acc, [(Opponent, Team, G1, G2)], NewAcc),  % then add the match to the list 
    matches_list(Team, NewAcc, Matches). % recall the function again to get another match

% base case
matches_list(_, Acc, Acc).              % return list of matches stored in the Acc  


%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_matches_of_team(Team, Count) :-        
    matches_of_team(Team, Matches),  
    length(Matches, Count).       

%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 7 %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
