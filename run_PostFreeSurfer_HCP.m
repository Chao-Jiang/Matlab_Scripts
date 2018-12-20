function run_PostFreeSurfer_HCP(subject, myPath, bash_profile)
surfatlasdir = '${HCPPIPEDIR_Templates}/standard_mesh_atlases';
grayordinatesdir = '${HCPPIPEDIR_Templates}/91282_Greyordinates';
grayordinatesres = '2';
hiresmesh = '164';
lowresmesh = '32';
subcortgraylabels = '${HCPPIPEDIR_Config}/FreeSurferSubcorticalLabelTableLut.txt';
freesurferlabels = '${HCPPIPEDIR_Config}/FreeSurferAllLut.txt';
refmyelinmaps = '${HCPPIPEDIR_Templates}/standard_mesh_atlases/Conte69.MyelinMap_BC.164k_fs_LR.dscalar.nii';
regname = 'MSMSulc';
syscommand(['$HCPPIPEDIR/PostFreeSurfer/PostFreeSurferPipeline.sh --path=' myPath ' --subject=' num2str(subject) ' --surfatlasdir=' surfatlasdir...
    ' --grayordinatesdir=' grayordinatesdir ' --grayordinatesres=' grayordinatesres ' --hiresmesh=' hiresmesh ' --lowresmesh=' lowresmesh...
    ' --subcortgraylabels=' subcortgraylabels ' --freesurferlabels=' freesurferlabels ' --refmyelinmaps=' refmyelinmaps ' --regname=' regname], bash_profile)