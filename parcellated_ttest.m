left_t = zeros(360,1);
left_p = zeros(360,1);
right_t = zeros(360,1);
right_p = zeros(360,1);

piano_left_auditory = left_aud_corrs(:,logical(pianist_group));
control_left_auditory = left_aud_corrs(:,~logical(pianist_group));
piano_right_auditory = right_aud_corrs(:,logical(pianist_group));
control_right_auditory = right_aud_corrs(:,~logical(pianist_group));

for area = 1:360
    [Hr,Pr,CIr,STATSr] = ttest2(piano_right_auditory(area,:), control_right_auditory(area,:));
    right_t(area) = STATSr.tstat;
    right_p(area) = Pr;
    [Hl,Pl,CIl,STATSl] = ttest2(piano_left_auditory(area,:), control_left_auditory(area,:));
    left_t(area) = STATSl.tstat;
    left_p(area) = Pl;
end