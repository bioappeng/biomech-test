Copyright (c) 2012, James Slegers
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in
      the documentation and/or other materials provided with the distribution

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

function struct2csv(s,fn)
% STRUCT2CSV(s,fn)
%
% Output a structure to a comma delimited file with column headers
%
%       s : any structure composed of one or more matrices and cell arrays
%      fn : file name
%
%      Given s:
%
%          s.Alpha = { 'First', 'Second';
%                      'Third', 'Fourth'};
%
%          s.Beta  = [[      1,       2;
%                            3,       4]];
%          
%          s.Gamma = {       1,       2;
%                            3,       4};
%
%          s.Epsln = [     abc;
%                          def;
%                          ghi];
% 
%      STRUCT2CSV(s,'any.csv') will produce a file 'any.csv' containing:
%
%         "Alpha",        , "Beta",   ,"Gamma",   , "Epsln",
%         "First","Second",      1,  2,      1,  2,   "abc",
%         "Third","Fourth",      3,  4,      3,  4,   "def",
%                ,        ,       ,   ,       ,   ,   "ghi",
%    
%      v.0.9 - Rewrote most of the code, now accommodates a wider variety
%              of structure children
%
% Written by James Slegers, james.slegers_at_gmail.com
% Covered by the BSD License
%

FID = fopen(fn,'w');
headers = fieldnames(s);
m = length(headers);
sz = zeros(m,2);

t = length(s);

for rr = 1:t
    l = '';
    for ii = 1:m
        sz(ii,:) = size(s(rr).(headers{ii}));   
        if ischar(s(rr).(headers{ii}))
            sz(ii,2) = 1;
        end
        l = [l,'"',headers{ii},'",',repmat(',',1,sz(ii,2)-1)];
    end

    l = [l,'\n'];

    fprintf(FID,l);

    n = max(sz(:,1));

    for ii = 1:n
        l = '';
        for jj = 1:m
            c = s(rr).(headers{jj});
            str = '';
            
            if sz(jj,1)<ii
                str = repmat(',',1,sz(jj,2));
            else
                if isnumeric(c)
                    for kk = 1:sz(jj,2)
                        str = [str,num2str(c(ii,kk)),','];
                    end
                elseif islogical(c)
                    for kk = 1:sz(jj,2)
                        str = [str,num2str(double(c(ii,kk))),','];
                    end
                elseif ischar(c)
                    str = ['"',c(ii,:),'",'];
                elseif iscell(c)
                    if isnumeric(c{1,1})
                        for kk = 1:sz(jj,2)
                            str = [str,num2str(c{ii,kk}),','];
                        end
                    elseif islogical(c{1,1})
                        for kk = 1:sz(jj,2)
                            str = [str,num2str(double(c{ii,kk})),','];
                        end
                    elseif ischar(c{1,1})
                        for kk = 1:sz(jj,2)
                            str = [str,'"',c{ii,kk},'",'];
                        end
                    end
                end
            end
            l = [l,str];
        end
        l = [l,'\n'];
        fprintf(FID,l);
    end
    fprintf(FID,'\n');
end

fclose(FID);
