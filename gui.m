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

% Last Modified by GUIDE v2.5 22-Feb-2018 12:08:34

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
[path, user_cance]=imgetfile();
if user_cance
    msgbox(sprintf('Select the image please'),'Error','Error')
    return
end
im = imread(path);
axes(handles.axes3);
imshow(im);


% --- Executes on button press in btn_grayscale.
function btn_grayscale_Callback(hObject, eventdata, handles)
% hObject    handle to btn_grayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
% imblack = im;
% imblack = 1- im;
% axes(handles.axes3);
% imshow(imblack);
% global image
imgray = (im(:,:,1)+im(:,:,2)+im(:,:,3))/3;
axes(handles.axes3);
imshow(imgray);

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
