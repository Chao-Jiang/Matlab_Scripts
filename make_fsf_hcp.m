function make_fsf_hcp(subject)

fsf_template_path = '/Volumes/home/piano_feat/design_template.fsf';
fid = fopen(fsf_template_path, 'r');
fsf_template = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
fsf_template = fsf_template{1};
for line = 1:length(fsf_template)
    line_txt = fsf_template{line};
    if contains(line_txt, 'SUBJECT')
        line_txt = replace(line_txt, 'SUBJECT', num2str(subject));
        fsf_template{line} = line_txt;
    end
end
to_write = strjoin(fsf_template, '\n');
featdir = ['/Volumes/home/piano_feat/' num2str(subject) '.feat'];
mkdir(featdir);
fid = fopen([featdir '/design.fsf'], 'w');
fprintf(fid, '%s', to_write);
end
