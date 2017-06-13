function calcFDim(filename)
%чтение файла c2t после Tisean, поиск пика в автокорреляционной фунции и провозглашение его фрактальной размерностью. Запись ряда фрактальных размерностей для каждого dim в файл. 



clear peaks npeaks x y yy yfit np ret Block Data
%hold off
ret =[];
yy =[];
[Data,n] = ReadC2T(filename);
for i=1:n
        
    x=Data{i}(:,1);
    y=Data{i}(:,2);
    
    %     plot(x,y);   % рисунок до построения линии
    %     hold on
    
    [ac1, ac2] = autocorr(y,length(y)-1);
    %plot(ac2, ac1)
    
    [peaks, n] = findpeaks(ac1);
    %[peaks, n]= findpeaks(ac1,'MinPeakWidth',8);
    %peaks = -peaks;
    
    if(~isempty(peaks) && peaks(1) > 0)
        np = n(1);
        
        %npoint2 = y(end);
    else
        tmp = ac1(ac1 > 0);  np= length(tmp);   %индекс первой точка из y, автокорреляционная функция при которой меньше или равна нулю
        %point2 = y(end);
    end
    
    %p = polyfit(x(np:end), y(np:end), 1);          %аппроксимация 1 порядка от первого пика
    p = polyfit([x(np) x(end)], [y(np) y(end)], 1);
    
    %plot([x(np) x(end)] , [y(np) y(end)], 'rv');
    
    
    
    yfit = p(2)+x.*p(1);
  %  plot(x,yfit,'r');
  %  ylim([0,6]);
    
    disp(sprintf('y(np)=%d',y(np)));
    yy(i) = y(np);
    %disp(sprintf('p(%i) =%f\n',i, p(1)));
    %hold off
end


fclose('all');
fid = fopen('dimension.dat','w');
fprintf(fid, '%6.6f\n', yy); 
fclose(fid);
end



%%hold off


function [retData, n ]  = ReadC2T(filename)
    fclose('all');
    fileID = fopen([filename '' '.c2t'],'r');
    %fileID = fopen('Lorenz.dat.c2t','r');

    InputText = textscan(fileID, '#m=%d' ,1, 'Delimiter', '\n'); %здесь просто пропускается строка
    Block =1; %as m== 1

    while (~feof(fileID))
        %fprintf('Block: %s\n', num2str(Block));
        HeaderLines{Block,1} = InputText{1};

        FormatString = repmat('%f',1, 2);
        InputText = textscan(fileID, FormatString, ...    % Read data block
            'delimiter','\t');
        Data{Block,1} = cell2mat(InputText);
        [NumRows,NumCols] = size(Data{Block});           % Determine size of table
        %disp(cellstr(['Table data size: ' num2str(NumRows) ' x ' num2str(NumCols)]));
        %disp(' ');                                       % New line


        eob = textscan(fileID,'%s',1,'delimiter','\n');  % Read and discard end-of-block marker
        n = Block;
        Block = Block+1;
    end
    fclose(fileID);
    retData = Data;
end
