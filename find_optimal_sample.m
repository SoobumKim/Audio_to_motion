function [beat] = find_optimal_sample(sound_L_sum,sound_L)

cc = conv(sound_L_sum,sound_L(end:-1:1),'same'); % Xcorr using conv

abs_cc = abs(cc);

% Clustering
i = kmeans(abs_cc,2);
clust_1_index = find(i == 1);
clust_2_index = find(i == 2);

div_1 = zeros(numel(abs_cc),1);
div_2 = zeros(numel(abs_cc),1);

% Define range from clustering of abs(Xcorr)
div_1(clust_1_index,1) = abs_cc(clust_1_index,1);
div_2(clust_2_index,1) = abs_cc(clust_2_index,1);

if(max(div_1) > max(div_2))
    div_d = div_1;
else
    div_d = div_2;
end

% Delect zeros in sample
nonzero_sample = nonzeros(sound_L);

% Find index of max has distance, nonzero_sample
TF = islocalmax(div_d,'MinProminence',1, 'MinSeparation',length(nonzero_sample)/2);

max_point = find(TF == 1);

beat = zeros(length(sound_L_sum),1);
beat(max_point,1) = abs_cc(max_point,1);

end