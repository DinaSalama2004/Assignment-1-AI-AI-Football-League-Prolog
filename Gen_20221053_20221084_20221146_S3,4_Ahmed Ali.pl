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

% To get the max score of goals
% 1- create a list and append all players score to it
% 2- find the max from this list
% 3- return the max

% Collect all scores
get_all_scores(List) :- find_all_scores([], List).
find_all_scores(Acc, List) :- % Acc = []
    goals(Player, Score), % for each goals fact in the file
    \+ member(Score, Acc), % if the score is not member in Acc -unique list-
    find_all_scores([Score | Acc], List). % recursive call with new Acc after appending the current Score to it
find_all_scores(List, List). % base case to stop after finishing all goals facts

% Find the maximum
calculate_max_score([X], X). % base case is when only one element then it's the max
calculate_max_score([H|T], Max) :-
    calculate_max_score(T, MaxTail), % for each step we hold the head of the list
    (H > MaxTail -> Max = H ; Max = MaxTail). % backtrack and compare between head and max number from the tail

% Find the player with the max score
top_scorer(Player) :-
    get_all_scores(GoalsList),
    calculate_max_score(GoalsList, MaxGoals),
    goals(Player, MaxGoals), !. % cut to return only one answer

%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 7 %%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% To Find The Most Common Position in a Specific Team:
% 1- get all positions for the team
% 2- calculate the frequency number for each position
% 3- return the position for the max frequency number

% Get all positions for a the team
get_all_positions(Team, Positions) :- % return all positions in Positions list
    find_all_positions(Team, Positions, []).
find_all_positions(Team, Positions, Acc) :- % Acc = []
    player(_, Team, Position), % for each fact player in the team
    \+ member(Position, Acc), % to avoid same member
    find_all_positions(Team, Positions, [Position|Acc]). % recursively call the find rule after adding the curr position
find_all_positions(_, Positions, Positions). % base case when there is no other players

% Calculate the frequency number for each position
get_all_frequencies([], [], []). % the base case is when no positions
get_all_frequencies([H|T], Unique, Counts) :- % takes all positions and returns the Unique positions and Counts of each one
    find_all_frequencies(H, T, Rest, Count),
    get_all_frequencies(Rest, RestUnique, RestCounts),
    Unique = [H|RestUnique],
    Counts = [Count|RestCounts].

find_all_frequencies(_, [], [], 1). % if no more positions then the count is one
find_all_frequencies(H, [H|T], Rest, Count) :- % if H matches then increment count
    find_all_frequencies(H, T, Rest, NewCount),
    Count is NewCount + 1.
find_all_frequencies(H, [X|T], [X|Rest], Count) :- % if H is not a match, skip this position
    H \= X,
    find_all_frequencies(H, T, Rest, Count).

% Find the maximum frequency and its associated position
get_max_frequency([H], [F], H, F). % base case if only one element then it is the max
get_max_frequency([H1|T1], [F1|T2], MaxPos, MaxFreq) :-
    get_max_frequency(T1, T2, TempPos, TempFreq),
    (   F1 > TempFreq % compare and update if curr is higher
    ->  MaxPos = H1, MaxFreq = F1
    ;   MaxPos = TempPos, MaxFreq = TempFreq
    ).

% Find the most common position in a given team
most_common_position_in_team(Team, MostCommonPosition) :-
    get_all_positions(Team, Positions),
    get_all_frequencies(Positions, UniquePositions, Frequencies),
    get_max_frequency(UniquePositions, Frequencies, MostCommonPosition, _),
    !. % cut to prevent multiple answers
