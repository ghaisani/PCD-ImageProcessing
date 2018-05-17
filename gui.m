function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 17-May-2018 15:36:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% a = imread('bunga.jpg')
% global image
% [filename pathname] = uigetfile({'*.jpg';'*.jpeg';'*.png';'*.bmp'},'File selector');
% image = strcat(pathname, filename);
% axes(handles.axes3);
% imshow(image);

global im 
global filename
global oim
[filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
im = imread(filename);
oim = im;
axes(handles.axes3);
imshow(im)
% set(handles.SizeText,'string',im);
% path=imgetfile();
% if user_cance
%     msgbox(sprintf('Select the image please'),'Error','Error')
%     return
% end
% im = imread(filename);
% axes(handles.axes3);
% imshow(im);


% --- Executes on button press in btn_grayscale.
function btn_grayscale_Callback(hObject, eventdata, handles)
% hObject    handle to btn_grayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
im = (im(:,:,1)+im(:,:,2)+im(:,:,3))/3;
axes(handles.axes3);
imshow(im);

% --- Executes on button press in btn_zoomin.
function btn_zoomin_Callback(hObject, eventdata, handles)
% hObject    handle to btn_zoomin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
[m,n,colormap] = size(im);
if colormap==3
    x=im(:,:,1);
    y=im(:,:,2);
    z=im(:,:,3);
end
k = 1;
l = 1;
f = 2;

for i=1:m   %baca baris
    for t=1:f   %replikasi baris
        for j=1:n   %baca kolom
            for t=1:f   %replikasi kolom
                if colormap==3          %jika rgb
                    c1(k,l) = x(i,j);
                    c2(k,l) = y(i,j);
                    c3(k,l) = z(i,j);
                else
                    c(k,l) = im(i,j);   %jika grayscale
                end
                l=l+1;
            end
        end
        l=1;
        k=k+1;
    end
end
if colormap==3
    c(:,:,1)=c1;
    c(:,:,2)=c2;
    c(:,:,3)=c3;
end
figure
imshow(im) %fig 1
figure
imshow(c) %fig 2
im = c;
axes(handles.axes3);
imshow(im);

% --- Executes on button press in btn_zoomout.
function btn_zoomout_Callback(hObject, eventdata, handles)
% hObject    handle to btn_zoomout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
Ye = zeros(round(size(im,1)/2), round(size(im,2)/2), 3);
m = 1; %baris
n = 1; %colom
for i = 1:size(Ye,1)
    for j = 1:size(Ye,2)
        Ye(i,j,:) = im(m,n,:);
        n = round(n+2);
    end
    m = round(m+2);
    n = 1;
end
Ye = uint8(Ye);

figure
imshow(im);
figure
imshow(Ye);
im = Ye;
axes(handles.axes3);
imshow(im);

% --- Executes on button press in btn_invers.
function btn_invers_Callback(hObject, eventdata, handles)
% hObject    handle to btn_invers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
iminv = (255-(im(:,:,:)));
axes(handles.axes3);
imshow(iminv);


% --- Executes on button press in btnflipH.
function btnflipH_Callback(hObject, eventdata, handles)
% hObject    handle to btnflipH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global load;
axes(handles.axes3);
imshow(load,[]); pause(0.05);
im = flipH(im);
imshow(im,[]);

% --- Executes on button press in btnflipV.
function btnflipV_Callback(hObject, eventdata, handles)
% hObject    handle to btnflipV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global load;
axes(handles.axes3);
imshow(load,[]); pause(0.05);
im = flipV(im);
imshow(im,[]);



function nilaiX_Callback(hObject, eventdata, handles)
% hObject    handle to nilaiX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nilaiX as text
%        str2double(get(hObject,'String')) returns contents of nilaiX as a double


% --- Executes during object creation, after setting all properties.
function nilaiX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nilaiX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnGelapKur.
function btnGelapKur_Callback(hObject, eventdata, handles)
% hObject    handle to btnGelapKur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global load;
axes(handles.axes3);
imshow(load,[]); pause(0.05);

x = get(handles.nilaiX,'String');
x = str2double(x);
im = im-x;
axes(handles.axes3);
imshow(im,[]);

% --- Executes on button press in btnTerangTam.
function btnTerangTam_Callback(hObject, eventdata, handles)
% hObject    handle to btnTerangTam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global load;
axes(handles.axes3);
imshow(load,[]); pause(0.05);
x = get(handles.nilaiX,'String');
x = str2double(x);
im = im+x;
axes(handles.axes3);
imshow(im,[]);

% --- Executes on button press in btnGelapBagi.
function btnGelapBagi_Callback(hObject, eventdata, handles)
% hObject    handle to btnGelapBagi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global load;
axes(handles.axes3);
imshow(load,[]); pause(0.05);
x = get(handles.nilaiX,'String');
x = str2double(x);
im = im/x;
axes(handles.axes3);
imshow(im,[]);

% --- Executes on button press in btnTerangKali.
function btnTerangKali_Callback(hObject, eventdata, handles)
% hObject    handle to btnTerangKali (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global load;
axes(handles.axes3);
imshow(load,[]); pause(0.05);
x = get(handles.nilaiX,'String');
x = str2double(x);
im = im*x;
axes(handles.axes3);
imshow(im,[]);


% --- Executes on button press in btnCrop.
function btnCrop_Callback(hObject, eventdata, handles)
% hObject    handle to btnCrop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global load;
axes(handles.axes3);
imshow(load,[]); pause(0.05);
x = get(handles.nX,'String');
x = str2double(x);
y = get(handles.nY,'String');
y = str2double(y);
height = get(handles.nHeight,'String');
height = str2double(height);
width = get(handles.nWidth,'String');
width = str2double(width);
im = im(y:y+height-1, x:x+width-1, :)
imshow(im)



function nX_Callback(hObject, eventdata, handles)
% hObject    handle to nX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nX as text
%        str2double(get(hObject,'String')) returns contents of nX as a double


% --- Executes during object creation, after setting all properties.
function nX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nY_Callback(hObject, eventdata, handles)
% hObject    handle to nY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nY as text
%        str2double(get(hObject,'String')) returns contents of nY as a double


% --- Executes during object creation, after setting all properties.
function nY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nWidth_Callback(hObject, eventdata, handles)
% hObject    handle to nWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nWidth as text
%        str2double(get(hObject,'String')) returns contents of nWidth as a double


% --- Executes during object creation, after setting all properties.
function nWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nHeight_Callback(hObject, eventdata, handles)
% hObject    handle to nHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nHeight as text
%        str2double(get(hObject,'String')) returns contents of nHeight as a double


% --- Executes during object creation, after setting all properties.
function nHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in histogray.
function histogray_Callback(hObject, eventdata, handles)
% hObject    handle to histogray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
% im = (im(:,:,1)+im(:,:,2)+im(:,:,3))/3;
II = double(im);
figure
his = subplot(1,1,1);
ci = histc(reshape(II(:,:),[],1), 0:255);
bar(0:255, ci./max(ci), 'histc')
set(gca, 'XLim', [0 255], 'YLim',[0 1])
set(findobj(his,'Type','patch'), 'FaceColor','black', 'EdgeColor','none')
ylabel('Grayscale')
xlabel('Intensity')

% --- Executes on button press in historgb.
function historgb_Callback(hObject, eventdata, handles)
% hObject    handle to historgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
II = double(im);
figure
clr = 'rgb'; clrTxt = {'Red' 'Green' 'Blue'};
for i=1:3
    h = subplot(3,1,i);
    c = histc(reshape(II(:,:,i),[],1), 0:255);
    bar(0:255, c./max(c), 'histc')
    set(gca, 'XLim', [0 255], 'YLim',[0 1])
    set(findobj(h,'Type','patch'), 'FaceColor',clr(i), 'EdgeColor','none')
    ylabel(clrTxt{i})
end
xlabel('Intensity')


% --- Executes on button press in edge.
function edge_Callback(hObject, eventdata, handles)
% hObject    handle to edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
for k=1:3
    mk(:,:,k) = [0 1 0 ; 1 -4 1 ; 0 1 0];
end
m = zeros(size(im,1)+2, size(im,2)+2, size(im,3));
m(2:end-1, 2:end-1,:) = im(:,:,:);
for i = 1:size(im,1)
    for j = 1:size(im,2)
        kali = m(i:i+2,j:j+2,:);
        hasil(i,j,:) = sum(sum(kali.*mk));
    end
end
hasil = uint8(hasil);
axes(handles.axes3);
imshow(hasil);


% --- Executes on button press in sharp.
function sharp_Callback(hObject, eventdata, handles)
% hObject    handle to sharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
for k=1:3
    mk(:,:,k) = [0 -1 0 ; -1 5 -1 ; 0 -1 0];
end
m = zeros(size(im,1)+2, size(im,2)+2, size(im,3));
m(2:end-1, 2:end-1,:) = im(:,:,:);
for i = 1:size(im,1)
    for j = 1:size(im,2)
        kali = m(i:i+2,j:j+2,:);
        hasil(i,j,:) = sum(sum(kali.*mk));
    end
end
hasil = uint8(hasil);
axes(handles.axes3);
imshow(hasil);

% --- Executes on button press in blur.
function blur_Callback(hObject, eventdata, handles)
% hObject    handle to blur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
for k=1:3
    mkb(:,:,k) = [1/9 1/9 1/9 ; 1/9 1/9 1/9 ; 1/9 1/9 1/9];
end
m = zeros(size(im,1)+2, size(im,2)+2, size(im,3));
m(2:end-1, 2:end-1,:) = im(:,:,:);
for i = 1:size(im,1)
    for j = 1:size(im,2)
        kali = m(i:i+2,j:j+2,:);
        hasil(i,j,:) = sum(sum(kali.*mkb));
    end
end
hasil = uint8(hasil);
axes(handles.axes3);
imshow(hasil);


% --- Executes on button press in meanfil.
function meanfil_Callback(hObject, eventdata, handles)
% hObject    handle to meanfil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
im = imnoise(im,'salt & pepper',0.02);
figure
imshow(im);

A = fspecial('average',3);
X = zeros(size(im));
for i = 1:3
    X(:,:,i) = conv2(double(im(:,:,i)),double(A),'same');
end
im = uint8(X);
axes(handles.axes3);
imshow(im);
% G = meanFiltering(G,3);

% --- Executes on button press in medianfil.
function medianfil_Callback(hObject, eventdata, handles)
% hObject    handle to medianfil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
im = imnoise(im,'salt & pepper',0.02);
% axes(handles.axes3);
figure
imshow(im);

X = zeros(size(im));
for i = 1:3
    X(:,:,i) = medfilt2(double(im(:,:,i)), [3 3]);
end
im = uint8(X);
axes(handles.axes3);
imshow(im);


% --- Executes on button press in modusfil.
function modusfil_Callback(hObject, eventdata, handles)
% hObject    handle to modusfil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
im = imnoise(im,'salt & pepper',0.02);
figure
imshow(im);

im = modusfilt(im,3);
axes(handles.axes3);
imshow(im);


% --- Executes on button press in magicwand.
function magicwand_Callback(hObject, eventdata, handles)
global im;
global filename;
magicwand1;


% --- Executes on button press in threshold.
function threshold_Callback(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
ra = get(handles.ra,'String');
ra = str2double(ra);
rb = get(handles.rb,'String');
rb = str2double(rb);
ga = get(handles.ga,'String');
ga = str2double(ga);
gb = get(handles.gb,'String');
gb = str2double(gb);
ba = get(handles.ba,'String');
ba = str2double(ba);
bb = get(handles.bb,'String');
bb = str2double(bb);
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);
out = r>rb & r<ra & g>gb & g<ga & b>bb & b<ba;
axes(handles.axes3);
imshow(out);



function rb_Callback(hObject, eventdata, handles)
% hObject    handle to rb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rb as text
%        str2double(get(hObject,'String')) returns contents of rb as a double


% --- Executes during object creation, after setting all properties.
function rb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ra_Callback(hObject, eventdata, handles)
% hObject    handle to ra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ra as text
%        str2double(get(hObject,'String')) returns contents of ra as a double


% --- Executes during object creation, after setting all properties.
function ra_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gb_Callback(hObject, eventdata, handles)
% hObject    handle to gb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gb as text
%        str2double(get(hObject,'String')) returns contents of gb as a double


% --- Executes during object creation, after setting all properties.
function gb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ga_Callback(hObject, eventdata, handles)
% hObject    handle to ga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ga as text
%        str2double(get(hObject,'String')) returns contents of ga as a double


% --- Executes during object creation, after setting all properties.
function ga_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bb_Callback(hObject, eventdata, handles)
% hObject    handle to bb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bb as text
%        str2double(get(hObject,'String')) returns contents of bb as a double


% --- Executes during object creation, after setting all properties.
function bb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ba_Callback(hObject, eventdata, handles)
% hObject    handle to ba (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ba as text
%        str2double(get(hObject,'String')) returns contents of ba as a double


% --- Executes during object creation, after setting all properties.
function ba_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ba (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dilasi.
function dilasi_Callback(hObject, eventdata, handles)
% hObject    handle to dilasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
ima = im2bw(im);
a = [1,1];
X = zeros(size(ima));
for i=1:size(ima,1)
    for j=1:size(ima,2)
        if (ima(i,j) ~= 0)
            X(i,j) = (ima(i,j) | a(1)) | (ima(i,j+1) | a(2));
            X(i,j+1) = X(i,j);
        end
    end
end
figure
imshow(ima);
axes(handles.axes3);
imshow(X);


% --- Executes on button press in erosi.
function erosi_Callback(hObject, eventdata, handles)
% hObject    handle to erosi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
ima = im2bw(im);
a = [1,1];
Y = zeros(size(ima));
for i=1:size(ima,1)
    for j=1:size(ima,2)
        if (ima(i,j) ~= 0)
            Y(i,j) = (ima(i,j) & a(1)) & (ima(i,j+1) & a(2));
            Y(i,j+1) = Y(i,j);
        end
    end
end
figure
imshow(ima);
axes(handles.axes3);
imshow(Y);


% --- Executes on button press in compress.
function compress_Callback(hObject, eventdata, handles)
% hObject    handle to compress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
global filename
InfoImage = imfinfo(filename);
set(handles.SizeText,'String',num2str(InfoImage.FileSize));
X = im;
[m,n,colormap] = size(X);
for i = 1:colormap
    for j = 1:m
        for k = 1:n
            switch X(m,n,i)
              case num2cell(0:30)
                X(m,n,i) = 15;
              case num2cell(31:60)
                X(m,n,i) = 45;
              case num2cell(61:90)
                X(m,n,i) = 75;
              case num2cell(91:120)
                X(m,n,i) = 105;
              case num2cell(121:150)
                X(m,n,i) = 135;
              case num2cell(151:180)
                X(m,n,i) = 165;
              case num2cell(181:210)
                X(m,n,i) = 195;
              case num2cell(211:255)
                X(m,n,i) = 230;
            end
        end
    end
end
newFileName = 'Hasil-kompresi.jpg';
imwrite(X,newFileName);
InfoImageR = imfinfo(newFileName);
set(handles.SizeRText,'String',num2str(InfoImageR.FileSize));


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global oim;
im = oim;
axes(handles.axes3);
imshow(im);


% --- Executes on button press in rotate180.
function rotate180_Callback(hObject, eventdata, handles)
% hObject    handle to rotate180 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
for i = 1:2
    im = rot(im,90);
end
axes(handles.axes3);
imshow(im);

% --- Executes on button press in rotate270.
function rotate270_Callback(hObject, eventdata, handles)
% hObject    handle to rotate270 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
for i = 1:3
    im = rot(im,90);
end
axes(handles.axes3);
imshow(im);

% --- Executes on button press in rotate90.
function rotate90_Callback(hObject, eventdata, handles)
% hObject    handle to rotate90 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
im = rot(im,90);
axes(handles.axes3);
imshow(im);
