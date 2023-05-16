function varargout = ProyekCitra(varargin)
% PROYEKCITRA MATLAB code for ProyekCitra.fig
%      PROYEKCITRA, by itself, creates a new PROYEKCITRA or raises the existing
%      singleton*.
%
%      H = PROYEKCITRA returns the handle to a new PROYEKCITRA or the handle to
%      the existing singleton*.
%
%      PROYEKCITRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROYEKCITRA.M with the given input arguments.
%
%      PROYEKCITRA('Property','Value',...) creates a new PROYEKCITRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProyekCitra_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProyekCitra_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProyekCitra

% Last Modified by GUIDE v2.5 16-May-2023 15:17:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProyekCitra_OpeningFcn, ...
                   'gui_OutputFcn',  @ProyekCitra_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ProyekCitra is made visible.
function ProyekCitra_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProyekCitra (see VARARGIN)

% Choose default command line output for ProyekCitra
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProyekCitra wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ProyekCitra_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in Open.
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
global G;
[nama , alamat] = uigetfile({'*.jpg';'*.jpeg';'*.bmp';'*.png';'*.tif'},'Browse Image'); %mengambil data
I = imread([alamat,nama]); %membaca data yg dipilih
handles.Img=I; %gambar terpilih disimpan ke I
guidata(hObject, handles); %mengarahkan gcbo ke objek yg fungsinya sedang di eksekusi
axes(handles.axes1); %akses akses1
imshow(I,[]); %menampilkan gambar
G=I; %menyimpan data I ke G, jd isinya sama G dg I, nanti G yang berubah karena image processingnya

red = G(:,:,1); % Red channel
green = G(:,:,2); % Green channel
blue = G(:,:,3); % Blue channel
axes(handles.axes4);
h = histogram(red(:),256);
h.FaceColor = [1 0 0];
h.EdgeColor = 'r';
hold on
h = histogram(green(:),256);
h.FaceColor = [0 1 0];
h.EdgeColor = 'g';
h = histogram(blue(:),256);
h.FaceColor = [0 0 1];
h.EdgeColor = 'b';


% --- Executes on button press in Grayscale.
function Grayscale_Callback(hObject, eventdata, handles)
% hObject    handle to Grayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Grayscale,'Value',1)
 
Img = handles.Img;
Gray = rgb2gray(Img);
 
axes(handles.axes3)
cla('reset')
imshow(Gray)
    
axes(handles.axes5)
cla('reset')
h = histogram(Gray(:),256);
    h.FaceColor = [0.5 0.5 0.5];
    h.EdgeColor = [0.5 0.5 0.5];

% --- Executes on button press in Negative.
function Negative_Callback(hObject, eventdata, handles)
% hObject    handle to Negative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Negative,'Value',1)
% Image Complement
Img = handles.Img;
Img_Comp = imcomplement(Img);
 
axes(handles.axes3)
cla('reset')
imshow(Img_Comp)

red = Img_Comp(:,:,1); % Red channel
green = Img_Comp(:,:,2); % Green channel
blue = Img_Comp(:,:,3); % Blue channel
axes(handles.axes5);
h = histogram(red(:),256);
h.FaceColor = [1 0 0];
h.EdgeColor = 'r';
hold on;
h = histogram(green(:),256);
h.FaceColor = [0 1 0];
h.EdgeColor = 'g';
h = histogram(blue(:),256);
h.FaceColor = [0 0 1];
h.EdgeColor = 'b';

% --- Executes on button press in Noise.
function Noise_Callback(hObject, eventdata, handles)
% hObject    handle to Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Noise,'Value',1)
Img = handles.Img;
Noise = imnoise(Img,'salt & pepper',0.02); %metode salt & pepper
 
axes(handles.axes3)
cla('reset')
imshow(Noise);

red = Noise(:,:,1); % Red channel
green = Noise(:,:,2); % Green channel
blue = Noise(:,:,3); % Blue channel
axes(handles.axes5);
h = histogram(red(:),256);
h.FaceColor = [1 0 0];
h.EdgeColor = 'r';
hold on;
h = histogram(green(:),256);
h.FaceColor = [0 1 0];
h.EdgeColor = 'g';
h = histogram(blue(:),256);
h.FaceColor = [0 0 1];
h.EdgeColor = 'b';


% --- Executes on button press in Sharpering.
function Sharpering_Callback(hObject, eventdata, handles)
% hObject    handle to Sharpering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Sharpering,'Value',1)
Img = handles.Img;
sharpFilter = fspecial('unsharp');
sharp = imfilter(Img, sharpFilter, 'replicate');

axes(handles.axes3)
cla('reset')
imshow(sharp);

red = sharp(:,:,1); % Red channel
green = sharp(:,:,2); % Green channel
blue = sharp(:,:,3); % Blue channel
axes(handles.axes5);
h = histogram(red(:),256);
h.FaceColor = [1 0 0];
h.EdgeColor = 'r';
hold on;
h = histogram(green(:),256);
h.FaceColor = [0 1 0];
h.EdgeColor = 'g';
h = histogram(blue(:),256);
h.FaceColor = [0 0 1];
h.EdgeColor = 'b';


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global frame

[nama_file_simpan, path_simpan]=uiputfile ({'*.jpg','JPG Image (.jpg)';},'Menyimpan Citra');


if isequal(nama_file_simpan,0) || isequal(path_simpan,0)
    msgbox('Image is saved', 'Foto_Editor')
else
    F=getframe(handles.axes3);
    img=frame2im(F);
    imwrite(img, fullfile(path_simpan,nama_file_simpan),'jpg');
end

axes(handles.axes3)

% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla('reset')
axes(handles.axes3)
cla('reset')
axes(handles.axes4)
cla('reset')
axes(handles.axes5)
cla('reset')



% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
popvalue = get(handles.popupmenu3,'value')

if (popvalue == 1)
    Img = handles.Img;
    gray=rgb2gray(Img);
    roberts = edge(gray,'roberts');

    axes(handles.axes3)
    cla('reset')
    imshow(roberts);
    
    axes(handles.axes5)
    cla('reset')
    h = histogram(gray(:),256);
    h = [1 0; 0 -1];
    h = [0 1; -1 0];
   
       

elseif(popvalue == 2)
    Img = handles.Img;
    gray=rgb2gray(Img);
    canny = edge(gray,'canny');

    axes(handles.axes3)
    cla('reset')
    imshow(canny);
    
    axes(handles.axes5)
    cla('reset')
    imhist(canny);
    
    
elseif(popvalue == 3)
    Img = handles.Img;
    gray=rgb2gray(Img);
    prewitt = edge(gray,'prewitt');

    axes(handles.axes3)
    cla('reset')
    imshow(prewitt);
    
    axes(handles.axes5)
    cla('reset')
    imhist(prewitt);
    h = histogram(gray(:),256);
    h = [-1 0 1; -1 0 1; -1 0 1];
    h = [-1 -1 -1; 0 0 0; 1 1 1];
    
  
end


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in brightening.
function brightening_Callback(hObject, eventdata, handles)
% hObject    handle to brightening (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.brightening,'Value',1)
% Brightening
Img = handles.Img;
Img_Bright = Img + 50;

axes(handles.axes3); % Akses axes3 pada GUI
cla('reset')
imshow(Img_Bright, []); % Menampilkan citra hasil brightening dengan memperbarui rentang warna

% Update histogram
red = Img_Bright(:,:,1); % Red channel
green = Img_Bright(:,:,2); % Green channel
blue = Img_Bright(:,:,3); % Blue channel
axes(handles.axes5);
cla('reset');
h = histogram(red(:),256);
h.FaceColor = [1 0 0];
h.EdgeColor = 'r';
hold on;
h = histogram(green(:),256);
h.FaceColor = [0 1 0];
h.EdgeColor = 'g';
h = histogram(blue(:),256);
h.FaceColor = [0 0 1];
h.EdgeColor = 'b';

% Update handles structure
guidata(hObject, handles);




% --- Executes on button press in Smoothing.
function Smoothing_Callback(hObject, eventdata, handles)
% hObject    handle to Smoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global G; % Mengakses variabel global G yang berisi citra yang akan diproses
set(handles.Sharpering,'Value',1)
toggle = get(hObject,'Value'); % Mendapatkan status toggle Smoothing

if toggle % Jika Smoothing ditekan
    % Terapkan filter Gaussian
    if isfield(handles, 'OrigImg') % Jika telah dilakukan smoothing sebelumnya
        Img = handles.OrigImg;
    else % Jika belum dilakukan smoothing sebelumnya
        Img = handles.Img;
    end
    G = imgaussfilt(Img, 5);
    handles.OrigImg = Img; % Simpan citra sebelum di-smoothing

    axes(handles.axes3);
    cla('reset')
    imshow(G);

    red = G(:,:,1); % Red channel
    green = G(:,:,2); % Green channel
    blue = G(:,:,3); % Blue channel
    axes(handles.axes5);
    cla('reset');
    h = histogram(red(:),256);
    h.FaceColor = [1 0 0];
    h.EdgeColor = 'r';
    hold on;
    h = histogram(green(:),256);
    h.FaceColor = [0 1 0];
    h.EdgeColor = 'g';
    h = histogram(blue(:),256);
    h.FaceColor = [0 0 1];
    h.EdgeColor = 'b';
else % Jika Smoothing dilepas
    G = handles.Img; % Kembali ke citra awal sebelum dilakukan smoothing

    axes(handles.axes3);
    cla('reset')
    imshow(G);

    red = G(:,:,1); % Red channel
    green = G(:,:,2); % Green channel
    blue = G(:,:,3); % Blue channel
    axes(handles.axes5);
    cla('reset');
    h = histogram(red(:),256);
    h.FaceColor = [1 0 0];
    h.EdgeColor = 'r';
    hold on;
    h = histogram(green(:),256);
    h.FaceColor = [0 1 0];
    h.EdgeColor = 'g';
    h = histogram(blue(:),256);
    h.FaceColor = [0 0 1];
    h.EdgeColor = 'b';
end

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in Mirroring_Horizontal.
function Mirroring_Horizontal_Callback(hObject, eventdata, handles)
% hObject    handle to Mirroring_Horizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Mirroring_Horizontal

global G;
G = flip(G, 2); % mirror horizontal
axes(handles.axes3);
imshow(G, []);



% --- Executes on button press in Mirroring_Vertical.
function Mirroring_Vertical_Callback(hObject, eventdata, handles)
% hObject    handle to Mirroring_Vertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Mirroring_Vertical

global G;
G = flip(G, 1); % mirror vertical
axes(handles.axes3);
imshow(G, []);
