function make_fsf_melodic(subject, phase, tp)

fsf_template_path = '/Volumes/home/piano_melodic/design_template.fsf';
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
    if contains(line_txt, 'PHASE')
        line_txt = replace(line_txt, 'PHASE', phase);
        fsf_template{line} = line_txt;
    end
    if contains(line_txt, 'TIMEPOINTS')
        line_txt = replace(line_txt, 'TIMEPOINTS', tp);
        fsf_template{line} = line_txt;
    end
end
to_write = strjoin(fsf_template, '\n');
melodicdir = ['/Volumes/home/piano_melodic/' num2str(subject)];
if ~contains(fdir('/Volumes/home/piano_melodic'), num2str(subject))
    mkdir(melodicdir);
end
fid = fopen([melodicdir '/design_' phase '.fsf'], 'w');
fprintf(fid, '%s', to_write);
end
