function varargout = SlideForLumiance(varargin)
% SLIDEFORLUMIANCE MATLAB code for SlideForLumiance.fig
%      SLIDEFORLUMIANCE, by itself, creates a new SLIDEFORLUMIANCE or raises the existing
%      singleton*.
%
%      H = SLIDEFORLUMIANCE returns the handle to a new SLIDEFORLUMIANCE or the handle to
%      the existing singleton*.
%
%      SLIDEFORLUMIANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLIDEFORLUMIANCE.M with the given input arguments.
%
%      SLIDEFORLUMIANCE('Property','Value',...) creates a new SLIDEFORLUMIANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SlideForLumiance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SlideForLumiance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SlideForLumiance

% Last Modified by GUIDE v2.5 25-Nov-2017 20:39:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SlideForLumiance_OpeningFcn, ...
                   'gui_OutputFcn',  @SlideForLumiance_OutputFcn, ...
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


% --- Executes just before SlideForLumiance is made visible.
function SlideForLumiance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SlideForLumiance (see VARARGIN)

% Choose default command line output for SlideForLumiance


handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SlideForLumiance wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SlideForLumiance_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global L
L=[0:5:100];
global Lindex
Lindex=14;%1-21
global B
B=[-100:5:100];
global Bindex%1-41
Bindex=2;
global A
A=[-100:5:100];
global Aindex%1-41
Aindex=2;
global ABEN
ABEN=[-100:19:90];


set(handles.edit1,'string',num2str(L(Lindex)));
set(handles.edit2,'string',num2str(B(Bindex)));
set(handles.edit3,'string',num2str(A(Aindex)));



% --- Executes on slider movement.



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)%%L-button
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Lindex
global L
global B
global A
global ABEN
global Aindex
global Bindex
global option %choose the ITMO
Lindex=Lindex-1;
if get(handles.radiobutton1,'value')
    option=1; %akyuz
% elseif get(handles.radiobutton2,'value')
%     option=2;%bentarle
elseif get(handles.radiobutton3,'value')
    option=3;%bist
% elseif get(handles.radiobutton4,'value')
%     option=4;%maylan
end
if (Lindex>=1&&Lindex<=21)
    set(handles.edit1,'string',num2str(L(Lindex)));
    %plot(handles.axes1,A,L(A),'r*');%testing code
    
    switch option
        case 1
            load('alphaMap_AkyuzStep5.mat');
            AB=zeros(41,41);
            R=zeros(41,41);
            for i=1:41
                for j=1:41
                    AB(i,j)=alphaMap(L(Lindex)+1,A(i)+101,B(j)+101);
                    R(i,j)=determineRegion(L(Lindex),A(i),B(j));
                end
            end
            axes(handles.axes1);
            [X,Y]=meshgrid(A,B);
             mesh(X,Y,AB); 
              hidden off;
hold on;
for i=1:41
                for j=1:41
                    
                   switch R(i,j)
                       case 1
                           plot3(A(i),B(j),0,'*m');
                       case 2
                           plot3(A(i),B(j),0,'or');
                       case 3
                           plot3(A(i),B(j),0,'+y');
                       case 4
                           plot3(A(i),B(j),0,'<g');
                       case 5
                           plot3(A(i),B(j),0,'+c');
                       case 6
                           plot3(A(i),B(j),0,'>b');
                   end
                end
end
            hold off
            xlabel('A');
            ylabel('B');
            zlabel('alpha');
           
     %   case 2
%            load('alphaMap_Banterle.mat');
%             AB=zeros(11,11);
%             R=zeros(11,11);
%             for i=1:11
%                 for j=1:11
%                     AB(i,j)=alphaMap(L(Lindex)+1,ABEN(i)+101,B(j)+101);
%                     R(i,j)=determineRegion(L(Lindex),ABEN(i),B(j));
%                 end
%             end
%              axes(handles.axes1);
%             [X,Y]=meshgrid(ABEN,B);
%              mesh(X,Y,AB); 
%               hidden off;
% hold on;
% for i=1:11
%                 for j=1:11
%                     
%                    switch R(i,j)
%                        case 1
%                            plot3(ABEN(i),B(j),0,'*m');
%                        case 2
%                            plot3(ABEN(i),B(j),0,'pr');
%                        case 3
%                            plot3(ABEN(i),B(j),0,'+y');
%                        case 4
%                            plot3(ABEN(i),B(j),0,'<g');
%                        case 5
%                            plot3(ABEN(i),B(j),0,'sc');
%                        case 6
%                            plot3(ABEN(i),B(j),0,'>b');
%                    end
%                 end
% end
%             hold off
%             xlabel('A');
%             ylabel('B');
%             zlabel('alpha');
             
        case 3
            load('alphaMap_BistStep5.mat');
            R=zeros(41,41);
            AB=zeros(41,41);
            for i=1:41
                for j=1:41
                    AB(i,j)=alphaMap(L(Lindex)+1,A(i)+101,B(j)+101);
                    R(i,j)=determineRegion(L(Lindex),A(i),B(j));
                end
            end
            axes(handles.axes1);
            [X,Y]=meshgrid(A,B);
             mesh(X,Y,AB); 
             hidden off;
hold on;
for i=1:41
                for j=1:41
                    
                   switch R(i,j)
                       case 1
                           plot3(A(i),B(j),0,'*m');
                       case 2
                           plot3(A(i),B(j),0,'or');
                       case 3
                           plot3(A(i),B(j),0,'+y');
                       case 4
                           plot3(A(i),B(j),0,'<g');
                       case 5
                           plot3(A(i),B(j),0,'+c');
                       case 6
                           plot3(A(i),B(j),0,'>b');
                   end
                end
end
            hold off
            xlabel('A');
            ylabel('B');
            zlabel('alpha');

            
        %case 4
             %meshz(handles.axes1,a,b,alpha);
%              xlabel('A');
%             ylabel('B');
%             zlabel('alpha');
          
    end
else
    set(handles.edit1,'string','illegal L');

end






% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO) %L+button
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Lindex
global L
global B
global A
global ABEN
global Aindex
global Bindex
global option
Lindex=Lindex+1;
if get(handles.radiobutton1,'value')
    option=1;
% elseif get(handles.radiobutton2,'value')
%     option=2;
elseif get(handles.radiobutton3,'value')
    option=3;
% elseif get(handles.radiobutton4,'value')
%     option=4;
end
if (Lindex>=1&&Lindex<=21)
    set(handles.edit1,'string',num2str(L(Lindex)));
    %plot(handles.axes1,A,L(A),'r*');%testing code
    switch option
        case 1
              load('alphaMap_AkyuzStep5.mat');
            AB=zeros(41,41);
             R=zeros(41,41);
            for i=1:41
                for j=1:41
                    AB(i,j)=alphaMap(L(Lindex)+1,A(i)+101,B(j)+101);
                    R(i,j)=determineRegion(L(Lindex),A(i),B(j));
                end
            end
            
            [X,Y]=meshgrid(A,B);
            axes(handles.axes1);
             mesh(X,Y,AB); 
             hidden off;
hold on;
for i=1:41
                for j=1:41
                    
                   switch R(i,j)
                       case 1
                           plot3(A(i),B(j),0,'*m');
                       case 2
                           plot3(A(i),B(j),0,'or');
                       case 3
                           plot3(A(i),B(j),0,'+y');
                       case 4
                           plot3(A(i),B(j),0,'<g');
                       case 5
                           plot3(A(i),B(j),0,'+c');
                       case 6
                           plot3(A(i),B(j),0,'>b');
                   end
                end
end
            hold off
            xlabel('A');
            ylabel('B');
            zlabel('alpha');
        case 2
%              load('alphaMap_Banterle.mat');
%             AB=zeros(11,11);
%              R=zeros(11,11);
%             for i=1:11
%                 for j=1:11
%                     AB(i,j)=alphaMap(L(Lindex)+1,ABEN(i)+101,B(j)+101);
%                     R(i,j)=determineRegion(L(Lindex),ABEN(i),B(j));
%                 end
%             end
%               axes(handles.axes1);
%             [X,Y]=meshgrid(ABEN,B);
%              mesh(X,Y,AB); 
%              hidden off;
% hold on;
% for i=1:11
%                 for j=1:11
%                     
%                    switch R(i,j)
%                        case 1
%                            plot3(ABEN(i),B(j),0,'*m');
%                        case 2
%                            plot3(ABEN(i),B(j),0,'pr');
%                        case 3
%                            plot3(ABEN(i),B(j),0,'+y');
%                        case 4
%                            plot3(ABEN(i),B(j),0,'<g');
%                        case 5
%                            plot3(ABEN(i),B(j),0,'sc');
%                        case 6
%                            plot3(ABEN(i),B(j),0,'>b');
%                    end
%                 end
% end
%             hold off
%             xlabel('A');
%             ylabel('B');
%             zlabel('alpha');
        case 3
            load('alphaMap_BistStep5.mat');
              R=zeros(41,41);
            AB=zeros(41,41);
            for i=1:41
                for j=1:41
                    AB(i,j)=alphaMap(L(Lindex)+1,A(i)+101,B(j)+101);
                     R(i,j)=determineRegion(L(Lindex),A(i),B(j));
                end
            end
            
            [X,Y]=meshgrid(A,B);
             axes(handles.axes1);
             mesh(X,Y,AB);  
              hidden off;
hold on;
for i=1:41
                for j=1:41
                    
                   switch R(i,j)
                       case 1
                           plot3(A(i),B(j),0,'*m');
                       case 2
                           plot3(A(i),B(j),0,'or');
                       case 3
                           plot3(A(i),B(j),0,'+y');
                       case 4
                           plot3(A(i),B(j),0,'<g');
                       case 5
                           plot3(A(i),B(j),0,'+c');
                       case 6
                           plot3(A(i),B(j),0,'>b');
                   end
                end
end
            hold off
            xlabel('A');
            ylabel('B');
            zlabel('alpha');
        case 4
%              %meshz(handles.axes1,a,b,alpha);
%              xlabel('A');
%             ylabel('B');
%             zlabel('alpha');
             
    end
else
    set(handles.edit1,'string','illegal L, please set L to 0-100');
end





function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton1,'value',1);
%set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',0);
%set(handles.radiobutton4,'value',0);


% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(handles.radiobutton1,'value',0);
%set(handles.radiobutton2,'value',1);
set(handles.radiobutton3,'value',0);
%set(handles.radiobutton4,'value',0);



% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton1,'value',0);
%set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',1);
%set(handles.radiobutton4,'value',0);


% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton1,'value',0);
%set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',0);
%set(handles.radiobutton4,'value',1);


% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO) A-button plot gif in axes2
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Lindex
global L
global B
global A
global ABEN

global Aindex
global Bindex
global option
Aindex=Aindex-1;

if get(handles.radiobutton1,'value')
    option=1;
% elseif get(handles.radiobutton2,'value')
%     option=2;
elseif get(handles.radiobutton3,'value')
    option=3;
% elseif get(handles.radiobutton4,'value')
%     option=4;
end
if (Aindex>=1&&Aindex<=41)
    set(handles.edit2,'string',num2str(A(Aindex)));
    %plot(handles.axes1,A,L(A),'r*');%testing code
    switch option
        case 1
            set(handles.edit2,'string',num2str(A(Aindex)));
           load('alphaMap_AkyuzStep5.mat');
           Lmap=zeros(1,21);
            for i=1:21
                    Lmap(i)=alphaMap(L(i)+1,A(Aindex)+101,B(Bindex)+101);
             
            end
            axes(handles.axes2);
            plot(L,Lmap,'r-o');
            xlabel('L');
            ylabel('alpha');
            
        case 2
%             set(handles.edit2,'string',num2str(ABEN(Aindex)));
%             load('alphaMap_Banterle.mat');
%              Lmap=zeros(1,6);
%             for i=1:6
%                     Lmap(i)=alphaMap(L(i)+1,ABEN(Aindex)+101,B(Bindex)+101);
%              
%             end
%             axes(handles.axes2);
%             plot(L,Lmap,'r-o');
%             xlabel('L');
%             ylabel('alpha');
        case 3
           set(handles.edit2,'string',num2str(A(Aindex)));
            load('alphaMap_BistStep5.mat');
           Lmap=zeros(1,21);
            for i=1:21
                    Lmap(i)=alphaMap(L(i)+1,A(Aindex)+101,B(Bindex)+101);
             
            end
            axes(handles.axes2);
            plot(L,Lmap,'r-o');
            xlabel('L');
            ylabel('alpha');
        case 4
            %set(handles.edit2,'string',num2str(A(Aindex)));         
%meshz(handles.axes1,a,b,alpha);
%              xlabel('A');
%             ylabel('B');
%             zlabel('alpha');
           
    end
else
    set(handles.edit2,'string','illegal A');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO) A+button
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Lindex
global L
global B
global A
global ABEN
global Aindex
global Bindex
global option
Aindex=Aindex+1;
if get(handles.radiobutton1,'value')
    option=1;
% elseif get(handles.radiobutton2,'value')
%     option=2;
elseif get(handles.radiobutton3,'value')
    option=3;
% elseif get(handles.radiobutton4,'value')
%     option=4;
end
if (Aindex>=1&&Aindex<=41)
    set(handles.edit2,'string',num2str(A(Aindex)));
    %plot(handles.axes1,A,L(A),'r*');%testing code
    switch option
        case 1
           set(handles.edit2,'string',num2str(A(Aindex)));
            load('alphaMap_AkyuzStep5.mat');
           Lmap=zeros(1,21);
            for i=1:21
                    Lmap(i)=alphaMap(L(i)+1,A(Aindex)+101,B(Bindex)+101);
             
            end
            axes(handles.axes2);
            plot(L,Lmap,'r-o');
            xlabel('L');
            ylabel('alpha');
        case 2
%             set(handles.edit2,'string',num2str(ABEN(Aindex)));
%             load('alphaMap_Banterle.mat');
%              Lmap=zeros(1,6);
%             for i=1:6
%                     Lmap(i)=alphaMap(L(i)+1,ABEN(Aindex)+101,B(Bindex)+101);
%              
%             end
%             axes(handles.axes2);
%             plot(L,Lmap,'r-o');
%             xlabel('L');
%             ylabel('alpha');
        case 3
            set(handles.edit2,'string',num2str(A(Aindex)));
            load('alphaMap_BistStep5.mat');
           Lmap=zeros(1,21);
            for i=1:21
                    Lmap(i)=alphaMap(L(i)+1,A(Aindex)+101,B(Bindex)+101);
             
            end
            axes(handles.axes2);
            plot(L,Lmap,'r-o');
            xlabel('L');
            ylabel('alpha');
        case 4
             % set(handles.edit2,'string',num2str(A(Aindex)));          
%meshz(handles.axes1,a,b,alpha);
%              xlabel('A');
%             ylabel('B');
%             zlabel('alpha');
             
    end
else
    set(handles.edit2,'string','illegal A');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)%%B- button
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Lindex
global L
global B
global A
global ABEN
global Aindex
global Bindex
global option
Bindex=Bindex-1;
if get(handles.radiobutton1,'value')
    option=1;
% elseif get(handles.radiobutton2,'value')
%     option=2;
elseif get(handles.radiobutton3,'value')
    option=3;
% elseif get(handles.radiobutton4,'value')
%     option=4;
end
if (Bindex>=1&&Bindex<=41)
    set(handles.edit3,'string',num2str(B(Bindex)));
    %plot(handles.axes1,A,L(A),'r*');%testing code
    switch option
        case 1
         load('alphaMap_AkyuzStep5.mat');
           Lmap=zeros(1,21);
            for i=1:21
                    Lmap(i)=alphaMap(L(i)+1,A(Aindex)+101,B(Bindex)+101);
             
            end
            axes(handles.axes2);
            plot(L,Lmap,'r-o');
            xlabel('L');
            ylabel('alpha');
        case 2
%             load('alphaMap_Banterle.mat');
%              Lmap=zeros(1,6);
%             for i=1:6
%                     Lmap(i)=alphaMap(L(i)+1,ABEN(Aindex)+101,B(Bindex)+101);
%              
%             end
%             axes(handles.axes2);
%             plot(L,Lmap,'r-o');
%             xlabel('L');
%             ylabel('alpha');
        case 3
            load('alphaMap_BistStep5.mat');
           Lmap=zeros(1,21);
            for i=1:21
                    Lmap(i)=alphaMap(L(i)+1,A(Aindex)+101,B(Bindex)+101);
             
            end
            axes(handles.axes2);
            plot(L,Lmap,'r-o');
            xlabel('L');
            ylabel('alpha');
        case 4
%              %meshz(handles.axes1,a,b,alpha);
%              xlabel('A');
%             ylabel('B');
%             zlabel('alpha');
          
    end
else
    set(handles.edit3,'string','illegal B');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO) %%B+ button
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Lindex
global L
global B
global A
global ABEN
global Aindex
global Bindex
global option
Bindex=Bindex+1;
if get(handles.radiobutton1,'value')
    option=1;
% elseif get(handles.radiobutton2,'value')
%     option=2;
elseif get(handles.radiobutton3,'value')
    option=3;
% elseif get(handles.radiobutton4,'value')
%     option=4;
end
if (Bindex>=1&&Bindex<=41)
    set(handles.edit3,'string',num2str(B(Bindex)));
    %plot(handles.axes1,A,L(A),'r*');%testing code
    switch option
        case 1
            load('alphaMap_AkyuzStep5.mat');
           Lmap=zeros(1,21);
            for i=1:21
                    Lmap(i)=alphaMap(L(i)+1,A(Aindex)+101,B(Bindex)+101);
             
            end
            axes(handles.axes2);
            plot(L,Lmap,'r-o');
            xlabel('L');
            ylabel('alpha');
        case 2
%             load('alphaMap_Banterle.mat');
%              Lmap=zeros(1,6);
%             for i=1:6
%                     Lmap(i)=alphaMap(L(i)+1,ABEN(Aindex)+101,B(Bindex)+101);
%              
%             end
%             axes(handles.axes2);
%             plot(L,Lmap,'r-o');
%             xlabel('L');
%             ylabel('alpha');
        case 3
            load('alphaMap_BistStep5.mat');
           Lmap=zeros(1,21);
            for i=1:21
                    Lmap(i)=alphaMap(L(i)+1,A(Aindex)+101,B(Bindex)+101);
             
            end
            axes(handles.axes2);
            plot(L,Lmap,'r-o');
            xlabel('L');
            ylabel('alpha');
        case 4
%              %meshz(handles.axes1,a,b,alpha);
%              xlabel('A');
%             ylabel('B');
%             zlabel('alpha');
          
    end
else
    set(handles.edit3,'string','illegal B');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
