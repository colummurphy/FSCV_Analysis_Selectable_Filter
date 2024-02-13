%Patra map pinout CSC channels to electrode names
PCR_srcdir='A:\mit\injectrode\experiments\fscv\templates\pcr_templates\';
PCR_srcdir=fullfile('home','schwerdt','matlab','analysis','analysis','pcr_templates');
PCR_srcdir=[PCR_srcdir filesep];

%PCR_template='patra_clean_titanium_da_ph_bg_movep'; %generated cleaner with average of DA in vitro's and non-noisy BG/movement from patra 04/01/2018 for Patra titanium reference causing redox shifts
PCR_template='PCR_invitrophbgda_movement_comb';     %includes in vivo mvmtn from chronic 23, 27, 18 for Cleo analysis


csc_map={
     '7'     'c2' ...
     '8'    'cl5'...
     '9'    'cl4'...
     '908'  'cl4-cl5'...
     '10'   'cl3'...
     '9010' 'cl3-cl4'...
     '11'   'cl2'...
     '11010'    'cl2-cl3'...
     '12'   'p1'...
     '14'   'p4'...
     '15'   'p3'...
     '15014'    'p3-p4'...
     '12014'    'p1-p4'...
     '12015'    'p1-p3'...
     '16'   'p2'...
     '16012'    'p2-p1'...     
   '33'    'eyed'   ...
    '34'    'eyex'  ...
    '35'    'eyey'  ...    
    };
%{
csc_map={
    '2'     'c5' ...
    '3'     'c4' ...
    '4'     'c2' ...
    '203'   'c5-c4'...
    '204'   'c5-c2' ...
    '304'   'c4-c2' ...
    '5'     'cl5' ...
    '405'   'c2-cl5' ...
    '305'   'c4-cl5' ...
    '8'     'cl3' ...
    '9'     'cl2' ...
    '809'   'cl3-cl2'...
    '802'   'cl3-c5' ...
    '902'   'cl2-c5'...
    '10'    'cl1'   ...
    '9010'  'cl2-cl1'...
    '11'    'p4'   ...
    '12'    'p3'   ...
    '14'    'p2'   ...
    '15'    'p1'       ...
    '33'    'eyed'   ...
    '34'    'eyex'  ...
    '35'    'eyey'  ...    
    };
%}
event_codes={
    '4'     'display_fix' ...
    '5'     'start_fix' ...
    '6'     'break_fix' ...
    '10'    'display_target' ...
    '11'    'start_target'  ...
    '12'    'break_target'  ...
    '14'    'error' ...
    '29'    'left_condition'    ...
    '30'    'right_condition'   ...
    '45'    'reward_big'    ...
    '46'    'reward_small'  ...
    };
%07/27/2018 - found out left-condition/right_condition not proper fix spot
%on, need to use "display_fix" instead

%error_trial means fixation break, target fixation break, or something else
%ie # error > fix or target breaks
%but error < fix + target breaks + no enter trials (37)
%# correct trials (ie. id = 13) = = # 45 + #46
%however if we calculate total  trials based on #3 start trial cue) - successful
%trials(#13), get # error trials (14)
%If use #4 (fixspot on) as indicating total trials then this is equal to
%#37 (no enter) + #13 (correct) + #14 (error)
%29 & 30 presented at same as 4

