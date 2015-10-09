function model = objMakeBumpMap(model)

% OBJMAKEBUMPMAP

% Copyright (C) 2015 Toni Saarela
% 2015-06-01 - ts - first version
% 2015-10-08 - ts - bug fixes

switch model.shape
  case 'sphere'
    R = reshape(model.R,[model.n model.m])';
    if model.opts.mmap~=model.m || model.opts.nmap~=model.n
      Theta = model.Theta;
      Phi = model.Phi;
      Theta = reshape(Theta,[model.n model.m])';
      Phi = reshape(Phi,[model.n model.m])';
      
      theta2 = linspace(-pi,pi-2*pi/model.nmap,model.opts.nmap); % azimuth
      phi2 = linspace(-pi/2,pi/2,model.opts.mmap); % elevation
      [Theta2,Phi2] = meshgrid(theta2,phi2);
      model.opts.map = interp2(Theta2,Phi2,model.opts.map,Theta,Phi);
    end
    R = R + model.opts.ampl * model.opts.map;
    R = R'; model.R = R(:);
  case 'plane'
    ;
  case {'cylinder','revolution','extrusion'}
    ;
    % Remember the spinex and spinez options!
  case 'torus'
    ;
end
