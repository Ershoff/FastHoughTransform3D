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

function h = fht2core(m, sign)
  n = size(m, 2);
  if n < 2
    h = m;
    return
  end
  n0 = round(n / 2);
  h = mergeHT(fht2core(m(:, 1 : n0, :), sign), fht2core(m(:, n0 + 1 : n, :), sign), sign);
end

function h = mergeHT(h0, h1, sign)
  [m, n0, o] = size(h0);          % calculation of 'o' is rudimental, i.e. algo won't work for other dimentions
  n1 = size(h1, 2);               % in case when columns numumber is not power of 2
  n = n0 + n1;              
  h = zeros(m, n, o);             % 'o' is equal to one always
  r0 = (n0 - 1) / (n - 1);        % compute support for the lines of the left band
  r1 = (n1 - 1) / (n - 1);        % compute support for the lines of the right band
  for i = 1 : n
    t = i - 1;                    % tangent value
    t0 = round(t * r0);           % tangent of the left  half
    t1 = round(t * r1);           % tangent of the right half
    s = mod(sign * (t - t1), m);  % number of pixels that for given tangent must be replased to the tail (always positive)
    h(:, i, :) = h0(:, t0 + 1, :) + [h1(s + 1 : m, t1 + 1, :); h1(1 : s, t1 + 1, :)];
  end
end
