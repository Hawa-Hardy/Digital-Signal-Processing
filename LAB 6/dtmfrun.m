function keys = dtmfrun(xx, L, fs)
    center_freqs = [697 770 852 941 1209 1336 1477 1633];
    hh = dtmfdesign(center_freqs, L, fs);
    [nstart, nstop] = dtmfcut(xx, fs); % Find the beginning and end of tone bursts
    xx = xx * (2 / max(abs(xx)));
    keys = [];
    dtmf.keys = ...
        ['1','2','3','A';
         '4','5','6','B';
         '7','8','9','C';
         '*','0','#','D'];

    % Uncomment and use this section if needed
    % for ii=1: length(nstart)
    %     x_seg=xx(nstart(ii): nstop(ii)); % Extract one DTMF tone
    %     score= [];
    %     for i=1:8
    %         score(i) = dtmfscore(x_seg, hh(:, i));
    %     end
    %     jkl=find(score==1);
    %     if length(jkl)~=2 % error indicator
    %         keys(ii)=-1;
    %     else
    %         yy=jkl(2)-4;
    %         keys(ii)=dtmf.keys(jkl(1), yy);
    %     end
    % end

    for kk = 1:length(nstart) % cycle through each tone
        n = [];
        x_1 = xx(nstart(kk):nstop(kk)); % Extract one DTMF tone
        for i = 1:length(center_freqs) % cycle through each filter
            zz = dtmfscore(x_1, hh(:, i));
            n = [n, zz]; % create a vector of ones and zeros representing where the frequency components lie
        end
        aa = find(n == 1); % create a vector of indices where ones occur

        % Check for impossible scores and skip if they are found
        if length(aa) ~= 2 || aa(1) > 4 || aa(2) < 5
            keys = [keys, 'error'];
            continue
        end
        row = aa(1); % decode row position from aa
        col = aa(2) - 4; % decode column position from aa
        keys = [keys, dtmf.keys(row, col)]; % set keys equal to the current keys and the key found in this iteration
    end
end