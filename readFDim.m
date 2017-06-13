
fclose('all');
fileID = fopen('Lorenz.dat.c2t','r');

InputText = textscan(fileID, '#m=%d' ,1, 'Delimiter', '\n');
Block =1; %as m== 1

while (~feof(fileID))     
    fprintf('Block: %s\n', num2str(Block));
    HeaderLines{Block,1} = InputText{1};
    
    FormatString = repmat('%d',1, 2);
    InputText = textscan(fileID, FormatString, ...    % Read data block
      'delimiter','\t');
  Data{Block,1} = cell2mat(InputText);
  [NumRows,NumCols] = size(Data{Block});           % Determine size of table
   %disp(cellstr(['Table data size: ' num2str(NumRows) ' x ' num2str(NumCols)]));
   %disp(' ');                                       % New line
  
  
  eob = textscan(fileID,'%s',1,'delimiter','\n');  % Read and discard end-of-block marker
  Block = Block+1; 
end
fclose(fileID);