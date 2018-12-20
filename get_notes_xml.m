function note_vec = get_notes_xml(path)
my_x = xmlread(path);
notes = my_x.getElementsByTagName('Note');
note_vec = zeros(1, notes.getLength);
for i = 0:(notes.getLength-1)
    this_note = notes.item(i);
    id_elem = this_note.item(1);
    id = id_elem.item(0);
    note_vec(i+1) = str2double(id.getData);
end
   
