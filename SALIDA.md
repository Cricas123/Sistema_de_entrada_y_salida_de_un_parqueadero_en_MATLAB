# Sistema_de_entrada_y_salida_de_un_parqueadero_en_MATLAB
Sistema desarrollado en Matlab, que registra el ingreso y salida de trafico terrestre a un parqueadero, funciona mediante la lectura de código QR y para entender su funcionamiento, se usa servomotor como talanqueras de ingreso y salida.


 function varargout = PROYECTOparqueaderoPAGAR(varargin)
% PROYECTOPARQUEADEROPAGAR MATLAB code for PROYECTOparqueaderoPAGAR.fig
%      PROYECTOPARQUEADEROPAGAR, by itself, creates a new PROYECTOPARQUEADEROPAGAR or raises the existing
%      singleton*.
%
%      H = PROYECTOPARQUEADEROPAGAR returns the handle to a new PROYECTOPARQUEADEROPAGAR or the handle to
%      the existing singleton*.
%
%      PROYECTOPARQUEADEROPAGAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROYECTOPARQUEADEROPAGAR.M with the given input arguments.
%
%      PROYECTOPARQUEADEROPAGAR('Property','Value',...) creates a new PROYECTOPARQUEADEROPAGAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PROYECTOparqueaderoPAGAR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PROYECTOparqueaderoPAGAR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PROYECTOparqueaderoPAGAR

% Last Modified by GUIDE v2.5 12-Dec-2020 16:33:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PROYECTOparqueaderoPAGAR_OpeningFcn, ...
                   'gui_OutputFcn',  @PROYECTOparqueaderoPAGAR_OutputFcn, ...
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


% --- Executes just before PROYECTOparqueaderoPAGAR is made visible.
function PROYECTOparqueaderoPAGAR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PROYECTOparqueaderoPAGAR (see VARARGIN)

% Choose default command line output for PROYECTOparqueaderoPAGAR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PROYECTOparqueaderoPAGAR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PROYECTOparqueaderoPAGAR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Btnpagar.
function Btnpagar_Callback(hObject, eventdata, handles)
set(handles.Axescam,'visible','off');
axes(handles.Axescam);

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


for n=1:200
    img{n}=getsnapshot(vid);
    pause(1/256);
    message = decode_qr(img{n});
    X=length(message);
    
    if X ~=0
        disp(message)
        
        if X==3
            
            load('tiempo1.mat')
            fprintf('Usuario 1');
            T1=datetime('now');
            fprintf('\n El tiempo de entrada fue: %s',t1);
            fprintf('\n El tiempo de salida fue: %s',T1);
            re1=abs(t1-T1);
            [h,m,s] = hms(re1);
            tiempo1=round([h,m,s]);
            suma1=(tiempo1(1)*3600)+(tiempo1(2)*60)+tiempo1(3);
            resultado1=round(suma1*0.8);
            fprintf('\nEl costo a pagar es de: %f',resultado1);
            
            ard = arduino('COM5','uno');
            serv = servo(ard,'D4');
            closepreview
            set(handles.Axescam,'visible','off');
            axes(handles.Axescam);
            fondo = imread('PARQUEADERO.jpg');
            imshow(fondo);
            clc;
            set(handles.TextSalida,'String',char(T1));
            set(handles.TextPagar,'String',resultado1);
            for i=1:1
                writePosition(serv,0.5);
                pause(5);
                writePosition(serv,0);
                pause(1);
            end
            set(handles.TextSalida,'String','Hora de Salida');
            set(handles.TextPagar,'String','Valor a Pagar');
        end
        if X==4
            
            load('tiempo2.mat')
            fprintf('Usuario 2');
            T2=datetime('now');
            fprintf('\n El tiempo de entrada fue: %s',t2);
            fprintf('\n El tiempo de salida fue: %s',T2);
            re2=abs(t2-T2);
            [h,m,s] = hms(re2);
            tiempo2=round([h,m,s]);
            suma2=(tiempo2(1)*3600)+(tiempo2(2)*60)+tiempo2(3);
            resultado2=round(suma2*0.8);
            fprintf('\nEl costo a pagar es de: %f',resultado2);
            
            ard = arduino('COM5','uno');
            serv = servo(ard,'D4');
            closepreview
            set(handles.Axescam,'visible','off');
            axes(handles.Axescam);
            fondo = imread('PARQUEADERO.jpg');
            imshow(fondo);
            clc;
            set(handles.TextSalida,'String',char(T2));
            set(handles.TextPagar,'String',resultado2);
            for i=1:1
                writePosition(serv,0.5);
                pause(5);
                writePosition(serv,0);
                pause(1);
            end
            set(handles.TextSalida,'String','Hora de Salida');
            set(handles.TextPagar,'String','Valor a Pagar');
        end
        if X==5
            
            load('tiempo3.mat')
            fprintf('Usuario 3');
            T3=datetime('now');
            fprintf('\n El tiempo de entrada fue: %s',t3);
            fprintf('\n El tiempo de salida fue: %s',T3);
            re3=abs(t3-T3);
            [h,m,s] = hms(re3);
            tiempo3=round([h,m,s]);
            suma3=(tiempo3(1)*3600)+(tiempo3(2)*60)+tiempo3(3);
            resultado3=round(suma3*0.8);
            fprintf('\nEl costo a pagar es de: %f',resultado3);
            
            ard = arduino('COM5','uno');
            serv = servo(ard,'D4');
            closepreview
            set(handles.Axescam,'visible','off');
            axes(handles.Axescam);
            fondo = imread('PARQUEADERO.jpg');
            imshow(fondo);
            clc;
            set(handles.TextSalida,'String',char(T3));
            set(handles.TextPagar,'String',resultado3);
            for i=1:1
                writePosition(serv,0.5);
                pause(5);
                writePosition(serv,0);
                pause(1);
            end
            set(handles.TextSalida,'String','Hora de Salida');
            set(handles.TextPagar,'String','Valor a Pagar');
        end
        if X==6
            
            load('tiempo4.mat')
            fprintf('Usuario 4');
            T4=datetime('now');
            fprintf('\n El tiempo de entrada fue: %s',t4);
            fprintf('\n El tiempo de salida fue: %s',T4);
            re4=abs(t4-T4);
            [h,m,s] = hms(re4);
            tiempo4=round([h,m,s]);
            suma4=(tiempo4(1)*3600)+(tiempo4(2)*60)+tiempo4(3);
            resultado4=round(suma4*0.8);
            fprintf('\nEl costo a pagar es de: %f',resultado4);
            
            ard = arduino('COM5','uno');
            serv = servo(ard,'D4');
            closepreview
            set(handles.Axescam,'visible','off');
            axes(handles.Axescam);
            fondo = imread('PARQUEADERO.jpg');
            imshow(fondo);
            clc;
            set(handles.TextSalida,'String',char(T4));
            set(handles.TextPagar,'String',resultado4);
            for i=1:1
                writePosition(serv,0.5);
                pause(5);
                writePosition(serv,0);
                pause(1);
            end
            set(handles.TextSalida,'String','Hora de Salida');
            set(handles.TextPagar,'String','Valor a Pagar');
        end
        if X==7
            
            load('tiempo5.mat')
            fprintf('Usuario 5');
            T5=datetime('now');
            fprintf('\n El tiempo de entrada fue: %s',t5);
            fprintf('\n El tiempo de salida fue: %s',T5);
            re5=abs(t5-T5);
            [h,m,s] = hms(re5);
            tiempo5=round([h,m,s]);
            suma5=(tiempo5(1)*3600)+(tiempo5(2)*60)+tiempo5(3);
            resultado5=round(suma5*0.8);
            fprintf('\nEl costo a pagar es de: %f',resultado5);
            
            ard = arduino('COM5','uno');
            serv = servo(ard,'D4');
            closepreview
            set(handles.Axescam,'visible','off');
            axes(handles.Axescam);
            fondo = imread('PARQUEADERO.jpg');
            imshow(fondo);
            clc;
            set(handles.TextSalida,'String',char(T5));
            set(handles.TextPagar,'String',resultado5);
            for i=1:1
                writePosition(serv,0.5);
                pause(5);
                writePosition(serv,0);
                pause(1);
            end
            set(handles.TextSalida,'String','Hora de Salida');
            set(handles.TextPagar,'String','Valor a Pagar');
        end
        if X==8
            
            load('tiempo6.mat')
            fprintf('Usuario 6');
            T6=datetime('now');
            fprintf('\n El tiempo de entrada fue: %s',t6);
            fprintf('\n El tiempo de salida fue: %s',T6);
            re6=abs(t6-T6);
            [h,m,s] = hms(re6);
            tiempo6=round([h,m,s]);
            suma6=(tiempo6(1)*3600)+(tiempo6(2)*60)+tiempo6(3);
            resultado6=round(suma6*0.8);
            fprintf('\nEl costo a pagar es de: %f',resultado6);
            
            ard = arduino('COM5','uno');
            serv = servo(ard,'D4');
            closepreview
            set(handles.Axescam,'visible','off');
            axes(handles.Axescam);
            fondo = imread('PARQUEADERO.jpg');
            imshow(fondo);
            clc;
            set(handles.TextSalida,'String',char(T6));
            set(handles.TextPagar,'String',resultado6);
            for i=1:1
                writePosition(serv,0.5);
                pause(5);
                writePosition(serv,0);
                pause(1);
            end
            set(handles.TextSalida,'String','Hora de Salida');
            set(handles.TextPagar,'String','Valor a Pagar');
        end
        break;
        
    end
    pause(1/256)
end
stoppreview(vid);
stop(vid);
closepreview(vid);
            
% --- Executes during object creation, after setting all properties.
function Axesfondo_CreateFcn(hObject, eventdata, handles)
imshow('PARQUEADERO.jpg');
