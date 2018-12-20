function dist_vec = calc_trial_score(ref_path, trial_path)

ref_notes = get_notes_xml(ref_path);
trial_notes = get_notes_xml(trial_path);
if length(trial_notes)>length(ref_notes)
    %decide what happens
else
    ref_notes = ref_notes(1:length(trial_notes));
    dist_vec = abs(trial_notes - ref_notes); % or maybe not abs?
end
end


