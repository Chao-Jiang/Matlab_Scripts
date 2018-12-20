%$Author: shlomi $
%$Date: 2005/06/15 12:53:26 $
%$Id: view3d.m 1.1 2005/06/15 12:53:26 shlomi Exp $
%$Source: z:/shlomi/workarea/src/mi_registration/z:/shlomi/repository/RCS/view3d.m $

function view3d(in_vol)

h = vol3d('cdata',in_vol,'texture','2D');
view(3); 
% Update view since 'texture' = '2D'
vol3d(h);  

