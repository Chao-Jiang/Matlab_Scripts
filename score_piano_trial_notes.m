function [score, allignment] = score_piano_trial_notes(xml_path)

AA = {'A', 'R', 'N', 'D', 'C', 'Q', 'E', 'G', 'H', 'I', 'L', 'K', 'M', 'F', 'P', 'S', 'T', 'W', 'Y', 'V', 'B', 'Z', 'X', '*'};
all_notes = [56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79]; %the range in furelis is 60-77. the rest is just to fill the space and has no significance.
AA_notes = '';
notes_played = get_notes_xml(xml_path);
for note = 1:length(notes_played)
    if notes_played(note) < 56 || notes_played(note) > 79
        notes_played(note) = 79; % notes out of the range will be converted to 79, to prevent errors in conversion to AA. this will result in a mismatch upon score calculations.
    AA_notes = [AA_notes AA{find(all_notes == notes_played(note))}];
end

my_scoring_mat = diag(ones(1,24)); % each match = 1; each mismatch = 0; 
full_ref_AA_notes =  {'B','V','B','V','B','S','Y','T','F','C','H','F','S','H','M','S','T','H','B','V','B','V','B',...
    'S','Y','T','F','C','H','F','S','H','T','S','F','S','T','Y','B','K','Z','B','Y','I','B','Y','T','H','Y','T','S'};
level = str2num(xml_path(length(xml_path)-14:length(xml_path)-13));
trial_num = str2num(xml_path(length(xml_path)-5:length(xml_path)-4)); % currently unused variable
notes_per_level = [1 4 9 13 17 22 27 31 35 39 43 47 51];

this_level_ref = join(full_ref_AA_notes(1:notes_per_level(level)), '');
this_level_ref = this_level_ref{1};
[score, allignment] = nwalign(AA_notes, this_level_ref, 'GAPOPEN', 0, 'EXTENDGAP', 0, 'SCORINGMATRIX', my_scoring_mat);
score = score/max([length(notes_played), length(this_level_ref)]); %normalise score to the length of either the ref, or the num of notes played if its longer (which is what penalises insertion errors)
end
