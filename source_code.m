classdef surehesaplama_ismailyasinkunt_241230005 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure              matlab.ui.Figure
        SreLabel              matlab.ui.control.Label
        Label                 matlab.ui.control.Label
        SaniyeEditField       matlab.ui.control.NumericEditField
        SaniyeEditFieldLabel  matlab.ui.control.Label
        DakikaEditField       matlab.ui.control.NumericEditField
        DakikaEditFieldLabel  matlab.ui.control.Label
        SifirlaButton         matlab.ui.control.Button
        CikartButton          matlab.ui.control.Button
        EkleButton            matlab.ui.control.Button
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.UIFigure.Name = 'Süre Hesaplama Programı';
        end

        % Button pushed function: EkleButton
        function EkleButtontopla(app, event)
            if isempty(app.UIFigure.UserData)
                app.UIFigure.UserData.toplamsaniye=0;
                app.UIFigure.UserData.gecmisdeger=[];
            end

            yenidakika = app.DakikaEditField.Value;
            yenisaniye = app.SaniyeEditField.Value;
            yenitoplamsaniye= (yenidakika*60)+yenisaniye;

            app.UIFigure.UserData.toplamsaniye=app.UIFigure.UserData.toplamsaniye+yenitoplamsaniye;
            app.UIFigure.UserData.gecmisdeger(end+1)=yenitoplamsaniye;

            toplam=app.UIFigure.UserData.toplamsaniye;

            dakika=floor(toplam/60);
            saniye=mod(toplam,60);
            
            app.Label.Text= sprintf("%02d:%02d", dakika, saniye);
        end

        % Button pushed function: CikartButton
        function CikartButtoncikart(app, event)
             if isempty(app.UIFigure.UserData)
                 app.UIFigure.UserData.toplamsaniye=0;
                 app.UIFigure.UserData.gecmisdeger=[];
             end
             dakika=app.DakikaEditField.Value;
             saniye=app.SaniyeEditField.Value;
             cikarilacak= (dakika*60)+saniye;

             app.UIFigure.UserData.toplamsaniye=max(app.UIFigure.UserData.toplamsaniye-cikarilacak, 0);

             toplam=app.UIFigure.UserData.toplamsaniye;
             dakika=floor(toplam/60);
             saniye=mod(toplam,60);
            
             app.Label.Text= sprintf("%02d:%02d", dakika, saniye);
        end

        % Button pushed function: SifirlaButton
        function SifirlaButtonsifirla(app, event)
            app.UIFigure.UserData=[];
            
            app.Label.Text="00.00";
            app.DakikaEditField.Value=0;
            app.SaniyeEditField.Value=0;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create EkleButton
            app.EkleButton = uibutton(app.UIFigure, 'push');
            app.EkleButton.ButtonPushedFcn = createCallbackFcn(app, @EkleButtontopla, true);
            app.EkleButton.FontSize = 22;
            app.EkleButton.Position = [116 94 100 36];
            app.EkleButton.Text = 'Ekle';

            % Create CikartButton
            app.CikartButton = uibutton(app.UIFigure, 'push');
            app.CikartButton.ButtonPushedFcn = createCallbackFcn(app, @CikartButtoncikart, true);
            app.CikartButton.FontSize = 22;
            app.CikartButton.Position = [280 94 100 36];
            app.CikartButton.Text = 'Cikart';

            % Create SifirlaButton
            app.SifirlaButton = uibutton(app.UIFigure, 'push');
            app.SifirlaButton.ButtonPushedFcn = createCallbackFcn(app, @SifirlaButtonsifirla, true);
            app.SifirlaButton.FontSize = 22;
            app.SifirlaButton.Position = [429 94 100 36];
            app.SifirlaButton.Text = 'Sifirla';

            % Create DakikaEditFieldLabel
            app.DakikaEditFieldLabel = uilabel(app.UIFigure);
            app.DakikaEditFieldLabel.HorizontalAlignment = 'right';
            app.DakikaEditFieldLabel.FontSize = 22;
            app.DakikaEditFieldLabel.Position = [72 252 72 29];
            app.DakikaEditFieldLabel.Text = 'Dakika';

            % Create DakikaEditField
            app.DakikaEditField = uieditfield(app.UIFigure, 'numeric');
            app.DakikaEditField.FontSize = 22;
            app.DakikaEditField.Position = [159 252 100 29];

            % Create SaniyeEditFieldLabel
            app.SaniyeEditFieldLabel = uilabel(app.UIFigure);
            app.SaniyeEditFieldLabel.HorizontalAlignment = 'right';
            app.SaniyeEditFieldLabel.FontSize = 22;
            app.SaniyeEditFieldLabel.Position = [72 200 72 29];
            app.SaniyeEditFieldLabel.Text = 'Saniye';

            % Create SaniyeEditField
            app.SaniyeEditField = uieditfield(app.UIFigure, 'numeric');
            app.SaniyeEditField.FontSize = 22;
            app.SaniyeEditField.Position = [159 200 100 29];

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.BackgroundColor = [0 0 0];
            app.Label.FontSize = 22;
            app.Label.FontColor = [1 1 1];
            app.Label.Position = [402 224 158 29];
            app.Label.Text = '                         ';

            % Create SreLabel
            app.SreLabel = uilabel(app.UIFigure);
            app.SreLabel.FontSize = 22;
            app.SreLabel.Position = [343 224 51 29];
            app.SreLabel.Text = 'Süre';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = surehesaplama_ismailyasinkunt_241230005

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
