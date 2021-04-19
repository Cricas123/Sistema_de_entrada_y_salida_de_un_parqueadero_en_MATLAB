function varargout = PROYECTOparqueadero(varargin)
% PROYECTOPARQUEADERO MATLAB code for PROYECTOparqueadero.fig
%      PROYECTOPARQUEADERO, by itself, creates a new PROYECTOPARQUEADERO or raises the existing
%      singleton*.
%
%      H = PROYECTOPARQUEADERO returns the handle to a new PROYECTOPARQUEADERO or the handle to
%      the existing singleton*.
%
%      PROYECTOPARQUEADERO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROYECTOPARQUEADERO.M with the given input arguments.
%
%      PROYECTOPARQUEADERO('Property','Value',...) creates a new PROYECTOPARQUEADERO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PROYECTOparqueadero_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PROYECTOparqueadero_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PROYECTOparqueadero

% Last Modified by GUIDE v2.5 14-Dec-2020 14:43:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PROYECTOparqueadero_OpeningFcn, ...
                   'gui_OutputFcn',  @PROYECTOparqueadero_OutputFcn, ...
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


% --- Executes just before PROYECTOparqueadero is made visible.
function PROYECTOparqueadero_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PROYECTOparqueadero (see VARARGIN)

% Choose default command line output for PROYECTOparqueadero
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PROYECTOparqueadero wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PROYECTOparqueadero_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Btndetectar.
function Btndetectar_Callback(hObject, eventdata, handles)
javaaddpath('core.jar');
javaaddpath('javase.jar');

set(handles.Axescam,'visible','on');
axes(handles.Axescam);

vid = videoinput('winvideo', 1, 'YUY2_640x480');
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;
vid.ReturnedColorspace = 'rgb';
vidRes = get(vid,'videoResolution');
nBands = get(vid,'NumberofBands');
hImage = image(zeros(vidRes(2),vidRes(1),nBands));
preview(vid,hImage);
start(vid);

for n=1: 100
    img{n} = getsnapshot(vid);
    message = decode_qr(img{n});
    X=length(message);
    
    if X ~=0
        disp(message)
        
        if X==3
            
            t1=datetime('now');
            save('tiempo1','t1')
            ard = arduino('COM5','uno');
            serv = servo(ard,'D3');
            closepreview
            set(handles.Axescam,'visible','off');
            axes(handles.Axescam);
            fondo = imread('PARQUEADERO.jpg');
            imshow(fondo);
            clc;
            fprintf('Usuario 1');
            set(handles.TextEntrada,'String',char(t1));
            for i=1:1
                writePosition(serv,0.5);
                pause(5);
                writePosition(serv,0);
                pause(1);
            end
            set(handles.TextEntrada,'String','Hora de Entrada');
        end
        
        if X==4
            
            t2=datetime('now');
            save('tiempo2','t2')
            ard = arduino('COM5','uno');
            serv = servo(ard,'D3');
            
            closepreview
            set(handles.Axescam,'visible','off');
            axes(handles.Axescam);
            fondo = imread('PARQUEADERO.jpg');
            imshow(fondo);
            clc;
            fprintf('Usuario 2');
            set(handles.TextEntrada,'String',char(t2));
            for i=1:1
                writePosition(serv,0.5);
                pause(5);
                writePosition(serv,0);
                pause(1);
            end
            set(handles.TextEntrada,'String','Hora de Entrada');
        end
            
            
        if X==5
            
            t3=datetime('now');
            save('tiempo3','t3')
            ard = arduino('COM5','uno');
            serv = servo(ard,'D3');
            closepreview
            set(handles.Axescam,'visible','off');
            axes(handles.Axescam);
            fondo = imread('PARQUEADERO.jpg');
            imshow(fondo);
            clc;
            fprintf('Usuario 3');
            set(handles.TextEntrada,'String',char(t3));
            for i=1:1
                writePosition(serv,0.5);
                pause(5);
                writePosition(serv,0);
                pause(1);
            end
            set(handles.TextEntrada,'String','Hora de Entrada');
        end
        
        if X==6
            
            t4=datetime('now');
            save('tiempo4','t4')
            ard = arduino('COM5','uno');
            serv = servo(ard,'D3');
            closepreview
            set(handles.Axescam,'visible','off');
            axes(handles.Axescam);
            fondo = imread('PARQUEADERO.jpg');
            imshow(fondo);
            clc;
            fprintf('Usuario 4');
            set(handles.TextEntrada,'String',char(t4));
            for i=1:1
                writePosition(serv,0.5);
                pause(5);
                writePosition(serv,0);
                pause(1);
            end
            set(handles.TextEntrada,'String','Hora de Entrada');
        end
        
        if X==7
            
            t5=datetime('now');
            save('tiempo5','t5')
            ard = arduino('COM5','uno');
            serv = servo(ard,'D3');
            closepreview
            set(handles.Axescam,'visible','off');
            axes(handles.Axescam);
            fondo = imread('PARQUEADERO.jpg');
            imshow(fondo);
            clc;
            fprintf('Usuario 5');
            set(handles.TextEntrada,'String',char(t5));
            for i=1:1
                writePosition(serv,0.5);
                pause(5);
                writePosition(serv,0);
                pause(1);
            end
            set(handles.TextEntrada,'String','Hora de Entrada');
        end
        
        if X==8
            
            t6=datetime('now');
            save('tiempo6','t6')
            ard = arduino('COM5','uno');
            serv = servo(ard,'D3');
            closepreview
            set(handles.Axescam,'visible','off');
            axes(handles.Axescam);
            fondo = imread('PARQUEADERO.jpg');
            imshow(fondo);
            clc;
            fprintf('Usuario 6');
            set(handles.TextEntrada,'String',char(t6));
            for i=1:1
                writePosition(serv,0.5);
                pause(5);
                writePosition(serv,0);
                pause(1);
            end
            set(handles.TextEntrada,'String','Hora de Entrada');
        end
        
        break;
    end
    pause(1/256);
    
end
stoppreview(vid);
stop(vid);
closepreview(vid);

% --- Executes during object creation, after setting all properties.
function Axesfondo_CreateFcn(hObject, eventdata, handles)
imshow('PARQUEADERO.jpg');