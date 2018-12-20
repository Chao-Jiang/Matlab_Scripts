function tempo_vec = calc_time_diffs(path)
% takes an xml path, calls 'get_times_xml' and gets the time point vector
% for each note, and calcs the difference in seconds between each 2
% adjacent notes
time_cell = get_times_xml(path);
tempo_vec = zeros(1, length(time_cell)-1);
for point = 2:length(time_cell)
    diff_vec = time_cell{point} - time_cell{point-1};
    diff =  sum(diff_vec.*[3600 60 1]);
    tempo_vec(point-1) = diff;
end
