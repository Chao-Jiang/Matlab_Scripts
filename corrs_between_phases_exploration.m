trial_num = 1000000;
corr_diff = zeros(trial_num, 1);
for i = 1:trial_num
    flag = 1;
    while flag
        vox1 = randi(902629, 1, 1);
        dts1_AP = mock_dtseries_AP(vox1,:);
        dts1_PA = mock_dtseries_PA(vox1,:);
        if any(dts1_AP) && any(dts1_PA)  %check if its not an all zero time series
            flag = 0;
        end
    end
    flag = 1;      
    while flag
        vox2 = randi(902629, 1, 1);
        dts2_AP = mock_dtseries_AP(vox2,:);
        dts2_PA = mock_dtseries_PA(vox2,:);
        if any(dts2_AP) && any(dts2_PA) %check if its not an all zero time series
            flag = 0;
        end
    end
    corr_AP = corrcoef(dts1_AP, dts2_AP);
    corr_PA = corrcoef(dts1_PA, dts2_PA);
    corr_diff(i) = abs(corr_AP(2)) - abs(corr_PA(2));
end
hist(corr_diff, 50); shg
