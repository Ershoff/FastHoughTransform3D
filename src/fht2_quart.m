% Copyright (c) 2015, Owners: Visillect Service, Cognitive technologies,
% Smart Engines
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% 1. Redistributions of source code must retain the above copyright notice, this
%    list of conditions and the following disclaimer.
% 2. Redistributions in binary form must reproduce the above copyright notice,
%    this list of conditions and the following disclaimer in the documentation
%    and/or other materials provided with the distribution.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
% ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
% ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
% 
% The views and conclusions contained in the software and documentation are those
% of the authors and should not be interpreted as representing official policies,
% either expressed or implied, of the FreeBSD Project.

% Authors: D. P. Nikolaev, S. M. Karpenko, E.I. Ershov
% Contact information:
% ershov@iitp.ru
% dimonstr@iitp.ru


function h = fht2_quart(m)
  sm = size(m);
  if ( sm(1) ~= sm(2) )
    [v, i] = max(sm(1 : 2));
    m = resizeNearest(m, 3 - i, v);
  end
  h = fht2core(m, 1);       % primary-horrizantal with right tangent
end

function mato = resizeNearest(mati, dim, siz)
  num_dims = max(ndims(mati), dim);                     % Has it purpose instead made num_dims be equals 2 ?
  subscripts = {':'};
  subscripts = subscripts(1, ones(1, num_dims));        % make from {':'} -> {':',':'}
  indices = round((1 : siz) * (size(mati, dim) / siz)); % spread min dimention through maximal one.
  subscripts{dim} = indices;                            % assign array of indices to smallest dimention of mati
  mato = mati(subscripts{:});                           % making square matix
end
