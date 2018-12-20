function syscommand(command, bash_profile)
if ~exist('bash_profile', 'var')
    bash_profile = '/Users/georgieboy/.bash_profile';
end
system(['source ' bash_profile '; ' command]);
end