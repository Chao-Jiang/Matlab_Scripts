function Times_cell = get_times_xml(path)
my_x = xmlread(path);
notes = my_x.getElementsByTagName('Note');
for i = 0:(notes.getLength-1)
    this_note = notes.item(i);
    time_elem = this_note.item(5);
    time = time_elem.item(0);
    time = char(time.getData);
    time_cell = split(time, ':');
    vec = [str2double(time_cell{1}(end-1:end)), str2double(time_cell{2}), str2num(time_cell{3})];
    Times_cell{i+1} = vec;
end