<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="Excel.aspx.cs" Inherits="Quiz_Management_System.Excel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!--  SweetAlert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .upload-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            width: 100%;
            box-sizing: border-box;
        }

        /* Format Info Card */
        .format-info {
            background: #fff3cd;
            border: 2px solid #ffc107;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 30px;
            overflow: hidden;
        }

        .format-header {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            gap: 15px;
        }

        .format-info h3 {
            color: #ff9800;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 1.2rem;
            flex: 1;
            min-width: 250px;
        }

            .format-info h3::before {
                content: "ℹ";
                display: inline-block;
                width: 24px;
                height: 24px;
                background: #ff9800;
                color: white;
                border-radius: 50%;
                text-align: center;
                line-height: 24px;
                flex-shrink: 0;
            }

        .download-sample-btn {
            background: #3498db;
            color: white !important;
            padding: 10px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            white-space: nowrap;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

            .download-sample-btn:hover {
                background: #2980b9;
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
            }

        .column-format {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 6px;
            font-family: 'Courier New', monospace;
            margin: 15px 0;
            font-size: 0.95rem;
            line-height: 1.5;
            overflow-x: auto;
            white-space: nowrap;
            border: 1px solid #e9ecef;
            color: #333;
        }

        .note-section {
            margin-top: 15px;
            color: #666;
            font-size: 0.9rem;
            line-height: 1.4;
        }

            .note-section strong {
                color: #ff9800;
            }

        /* Upload Section */
        .upload-section {
            background: white;
            border: 2px dashed #ddd;
            border-radius: 8px;
            padding: 40px 20px;
            text-align: center;
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }

            .upload-section:hover {
                border-color: #3498db;
                background: #f8fafc;
            }

        .btn-choose {
            background: #3498db;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.2);
        }

            .btn-choose:hover {
                background: #2980b9;
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(52, 152, 219, 0.3);
            }

            .btn-choose:active {
                transform: translateY(0);
            }

        .file-name {
            margin-top: 15px;
            color: #333;
            font-weight: 500;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 6px;
            display: none;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
            word-break: break-all;
        }

        .file-info {
            margin-top: 20px;
            color: #666;
            font-size: 0.9rem;
            line-height: 1.6;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Loading Overlay */
        .loading-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.7);
            z-index: 9999;
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(3px);
        }

        .loading-content {
            text-align: center;
            color: white;
            padding: 30px;
            background: rgba(0,0,0,0.8);
            border-radius: 12px;
            max-width: 400px;
            width: 90%;
        }

        .spinner {
            border: 4px solid #f3f3f3;
            border-top: 4px solid #3498db;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
            margin: 0 auto 20px;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }

        /* Preview Panel */
        #divPreview {
            margin-top: 40px;
            background: #fefefe;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #ddd;
            overflow: hidden;
        }

        #grdPreview {
            width: 100%;
            overflow-x: auto;
            display: block;
            margin-bottom: 20px;
            border-collapse: collapse;
        }

            #grdPreview th {
                background-color: #3498db;
                color: white;
                padding: 12px 8px;
                text-align: left;
                font-weight: 600;
                white-space: nowrap;
                position: sticky;
                left: 0;
            }

            #grdPreview td {
                padding: 8px;
                border-bottom: 1px solid #eee;
                vertical-align: middle;
                color: #333;
            }

            #grdPreview tr:hover {
                background-color: #f8f9fa;
            }

        /* Action Buttons */
        .btn-action {
            background: #28a745;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-right: 10px;
            margin-bottom: 10px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.2);
        }

            .btn-action:hover {
                background: #218838;
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(40, 167, 69, 0.3);
            }

            .btn-action:active {
                transform: translateY(0);
            }

        .btn-cancel {
            background: #dc3545;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.2);
        }

            .btn-cancel:hover {
                background: #c82333;
                box-shadow: 0 6px 16px rgba(220, 53, 69, 0.3);
            }

        /* Grid Checkbox */
        #grdPreview input[type="checkbox"] {
            transform: scale(1.2);
            cursor: pointer;
        }

        /* Tablet Styles (768px - 1024px) */
        @media (max-width: 1024px) {
            .upload-container {
                padding: 15px;
            }

            .format-info {
                padding: 20px;
            }

                .format-info h3 {
                    font-size: 1.1rem;
                    min-width: 200px;
                }

            .column-format {
                font-size: 0.9rem;
                padding: 12px;
            }

            .upload-section {
                padding: 30px 15px;
            }

            .btn-choose {
                padding: 12px 24px;
                font-size: 0.95rem;
            }

            #divPreview {
                padding: 15px;
            }

            .btn-action {
                padding: 10px 16px;
                font-size: 0.9rem;
            }
        }

        /* Mobile Landscape (576px - 767px) */
        @media (max-width: 767px) {
            .upload-container {
                padding: 12px;
            }

            .format-info {
                padding: 18px;
                margin-bottom: 20px;
            }

            .format-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }

            .format-info h3 {
                font-size: 1rem;
                min-width: auto;
                width: 100%;
            }

            .download-sample-btn {
                width: 100%;
                justify-content: center;
                padding: 12px;
                font-size: 0.9rem;
            }

            .column-format {
                font-size: 0.85rem;
                padding: 10px;
                margin: 10px 0;
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }

            .upload-section {
                padding: 25px 12px;
                margin-bottom: 20px;
            }

            .btn-choose {
                width: 100%;
                max-width: 300px;
                justify-content: center;
                padding: 14px;
                font-size: 0.9rem;
            }

            .file-name {
                width: 100%;
                max-width: 100%;
                font-size: 0.9rem;
                padding: 8px;
            }

            .file-info {
                font-size: 0.85rem;
                width: 100%;
            }

            #divPreview {
                margin-top: 25px;
                padding: 12px;
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }

            #grdPreview {
                min-width: 800px;
            }

                #grdPreview th,
                #grdPreview td {
                    padding: 8px 6px;
                    font-size: 0.85rem;
                }

            .btn-action {
                width: 100%;
                margin-right: 0;
                margin-bottom: 10px;
                justify-content: center;
                padding: 14px;
                font-size: 0.9rem;
            }

            /* Button container for mobile */
            #divPreview .btn-action:last-child {
                margin-bottom: 0;
            }
        }

        /* Mobile Portrait (max-width: 575px) */
        @media (max-width: 575px) {
            .upload-container {
                padding: 10px;
            }

            .format-info {
                padding: 15px;
                border-width: 1px;
            }

                .format-info h3 {
                    font-size: 0.95rem;
                }

                    .format-info h3::before {
                        width: 20px;
                        height: 20px;
                        line-height: 20px;
                        font-size: 0.8rem;
                    }

            .note-section {
                font-size: 0.85rem;
            }

            .column-format {
                font-size: 0.8rem;
                padding: 8px;
            }

            .upload-section {
                padding: 20px 10px;
                border-width: 1px;
            }

            .btn-choose {
                padding: 12px;
                font-size: 0.85rem;
            }

            .file-name {
                font-size: 0.85rem;
            }

            .file-info {
                font-size: 0.8rem;
            }

            .loading-content {
                padding: 20px;
                width: 95%;
            }

                .loading-content h3 {
                    font-size: 1rem;
                }

                .loading-content p {
                    font-size: 0.9rem;
                }

            #grdPreview {
                min-width: 850px;
            }

                #grdPreview th {
                    padding: 10px 6px;
                    font-size: 0.8rem;
                }

                #grdPreview td {
                    padding: 6px;
                    font-size: 0.8rem;
                }

                /* Checkbox labels for mobile */
                #grdPreview .select-header,
                #grdPreview .select-cell {
                    min-width: 60px;
                }
        }

        /* Small Mobile Devices (max-width: 375px) */
        @media (max-width: 375px) {
            .upload-container {
                padding: 8px;
            }

            .format-info {
                padding: 12px;
            }

                .format-info h3 {
                    font-size: 0.9rem;
                }

            .download-sample-btn {
                font-size: 0.85rem;
                padding: 10px;
            }

            .btn-choose {
                font-size: 0.85rem;
                padding: 10px 16px;
            }

            .btn-action {
                font-size: 0.85rem;
                padding: 12px;
            }

            .file-info {
                font-size: 0.75rem;
            }
        }

        /* Touch Device Optimizations */
        @media (hover: none) and (pointer: coarse) {
            .btn-choose,
            .btn-action,
            .download-sample-btn {
                min-height: 44px;
            }

            #grdPreview input[type="checkbox"] {
                transform: scale(1.5);
                margin: 5px;
            }

            #grdPreview th,
            #grdPreview td {
                padding: 12px 8px;
            }

            /* Prevent text selection on buttons */
            .btn-choose,
            .btn-action,
            .download-sample-btn {
                user-select: none;
                -webkit-tap-highlight-color: transparent;
            }

            /* Better scrolling on mobile */
            #divPreview,
            #grdPreview,
            .column-format {
                -webkit-overflow-scrolling: touch;
                scrollbar-width: thin;
            }
        }

        /* Print Styles */
        @media print {
            .upload-section,
            .btn-choose,
            .btn-action,
            .download-sample-btn,
            .loading-overlay {
                display: none !important;
            }

            .format-info {
                border: 1px solid #000;
                background: none;
            }

            #divPreview {
                border: none;
                background: none;
            }

            #grdPreview {
                border-collapse: collapse;
            }

                #grdPreview th {
                    background-color: #fff !important;
                    color: #000 !important;
                    border: 1px solid #000;
                }

                #grdPreview td {
                    border: 1px solid #000;
                }
        }
    </style>

    <div class="upload-container">
        <!-- Format Info -->
        <div class="format-info">
            <div class="format-header">
                <h3>Excel Format Required:</h3>
                <asp:LinkButton ID="lnkDownloadSample" runat="server" CssClass="download-sample-btn" OnClick="lnkDownloadSample_Click">
                    📥 Download Sample Excel
                </asp:LinkButton>
            </div>
            <p>Your Excel file should have the following columns in this exact order:</p>
            <div class="column-format">
                Quiz Name | Question | Option A | Option B | Option C | Option D | Correct Option | Marks
            </div>
            <div class="note-section">
                <strong>Note:</strong> First row should be headers, data starts from row 2<br />
                <strong>Quiz Name:</strong> Enter the exact quiz name (case-insensitive). If quiz doesn't exist, question will be skipped.
            </div>
        </div>
<asp:Button ID="btnUploadHidden" runat="server" OnClick="btnUpload_Click" style="display:none;" />

        <!-- Upload Section -->
        <div class="upload-section">
            <asp:FileUpload ID="fileUploadExcel" runat="server"
                accept=".xlsx,.xls"
                style="display: none;"
                onchange="handleFileSelect(this)" />

            <button type="button" class="btn-choose"
                onclick="document.getElementById('<%=fileUploadExcel.ClientID%>').click();">
                Choose File
            </button>
        </div>

        <!-- Hidden Upload Button -->
        <asp:Button ID="btnUploadHidden"
            runat="server"
            OnClick="btnUpload_Click"
            style="display: none;" />


        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnUploadHidden" />
                <asp:PostBackTrigger ControlID="lnkDownloadSample" />
            </Triggers>
        </asp:UpdatePanel>

        <script>
            function handleFileSelect(input) {
                if (input.files && input.files[0]) {
                    var file = input.files[0];
                    var ext = file.name.split('.').pop().toLowerCase();

                    if (ext !== 'xlsx') {
                        Swal.fire('Invalid File', 'Only .xlsx files are supported. Please save your Excel file as .xlsx format.', 'error');
                        input.value = '';
                        return;
                    }

                    if (file.size > 5242880) {
                        Swal.fire('File Too Large', 'Maximum file size is 5 MB', 'error');
                        input.value = '';
                        return;
                    }

                    if (file.size < 100) {
                        Swal.fire('Invalid File', 'File appears to be empty or too small.', 'error');
                        input.value = '';
                        return;
                    }

                    document.getElementById('loadingOverlay').style.display = 'flex';
                    setTimeout(function () {
                        document.getElementById('<%=btnUploadHidden.ClientID%>').click();
        }, 100);
                }
            }
        </script>

        <!-- Loading Overlay -->
        <div class="loading-overlay" id="loadingOverlay">
            <div class="loading-content">
                <div class="spinner"></div>
                <h3>Uploading and Processing File...</h3>
                <p>Please wait while we process your Excel file</p>
            </div>
        </div>
</asp:Content>--%>







<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="Excel.aspx.cs" Inherits="Quiz_Management_System.Excel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .upload-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            width: 100%;
            box-sizing: border-box;
        }

        .format-info {
            background: #fff3cd;
            border: 2px solid #ffc107;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 30px;
            overflow: hidden;
        }

        .format-header {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            gap: 15px;
        }

        .format-info h3 {
            color: #ff9800;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 1.2rem;
            flex: 1;
            min-width: 250px;
        }

            .format-info h3::before {
                content: "ℹ";
                display: inline-block;
                width: 24px;
                height: 24px;
                background: #ff9800;
                color: white;
                border-radius: 50%;
                text-align: center;
                line-height: 24px;
                flex-shrink: 0;
            }

        .download-sample-btn {
            background: #3498db;
            color: white !important;
            padding: 10px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            white-space: nowrap;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

            .download-sample-btn:hover {
                background: #2980b9;
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
            }

        .column-format {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 6px;
            font-family: 'Courier New', monospace;
            margin: 15px 0;
            font-size: 0.95rem;
            line-height: 1.5;
            overflow-x: auto;
            white-space: nowrap;
            border: 1px solid #e9ecef;
            color: #333;
        }

        .note-section {
            margin-top: 15px;
            color: #666;
            font-size: 0.9rem;
            line-height: 1.4;
        }

            .note-section strong {
                color: #ff9800;
            }

        .upload-section {
            background: white;
            border: 2px dashed #ddd;
            border-radius: 8px;
            padding: 40px 20px;
            text-align: center;
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }

            .upload-section:hover {
                border-color: #3498db;
                background: #f8fafc;
            }

        .btn-choose {
            background: #3498db;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.2);
        }

            .btn-choose:hover {
                background: #2980b9;
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(52, 152, 219, 0.3);
            }

            .btn-choose:active {
                transform: translateY(0);
            }

        .file-info {
            margin-top: 20px;
            color: #666;
            font-size: 0.9rem;
            line-height: 1.6;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        .loading-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.7);
            z-index: 9999;
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(3px);
        }

        .loading-content {
            text-align: center;
            color: white;
            padding: 30px;
            background: rgba(0,0,0,0.8);
            border-radius: 12px;
            max-width: 400px;
            width: 90%;
        }

        .spinner {
            border: 4px solid #f3f3f3;
            border-top: 4px solid #3498db;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
            margin: 0 auto 20px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        #divPreview {
            margin-top: 40px;
            background: #fefefe;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #ddd;
            overflow: hidden;
        }

        #grdPreview {
            width: 100%;
            overflow-x: auto;
            display: block;
            margin-bottom: 20px;
            border-collapse: collapse;
        }

            #grdPreview th {
                background-color: #3498db;
                color: white;
                padding: 12px 8px;
                text-align: left;
                font-weight: 600;
                white-space: nowrap;
                position: sticky;
                left: 0;
            }

            #grdPreview td {
                padding: 8px;
                border-bottom: 1px solid #eee;
                vertical-align: middle;
                color: #333;
            }

            #grdPreview tr:hover {
                background-color: #f8f9fa;
            }

        .btn-action {
            background: #28a745;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-right: 10px;
            margin-bottom: 10px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.2);
        }

            .btn-action:hover {
                background: #218838;
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(40, 167, 69, 0.3);
            }

            .btn-action:active { transform: translateY(0); }

        .btn-cancel {
            background: #dc3545;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.2);
        }

            .btn-cancel:hover {
                background: #c82333;
                box-shadow: 0 6px 16px rgba(220, 53, 69, 0.3);
            }

        #grdPreview input[type="checkbox"] {
            transform: scale(1.2);
            cursor: pointer;
        }

        @media (max-width: 1024px) {
            .upload-container { padding: 15px; }
            .format-info { padding: 20px; }
            .format-info h3 { font-size: 1.1rem; min-width: 200px; }
            .column-format { font-size: 0.9rem; padding: 12px; }
            .upload-section { padding: 30px 15px; }
            .btn-choose { padding: 12px 24px; font-size: 0.95rem; }
            #divPreview { padding: 15px; }
            .btn-action { padding: 10px 16px; font-size: 0.9rem; }
        }

        @media (max-width: 767px) {
            .upload-container { padding: 12px; }
            .format-info { padding: 18px; margin-bottom: 20px; }
            .format-header { flex-direction: column; align-items: flex-start; gap: 12px; }
            .format-info h3 { font-size: 1rem; min-width: auto; width: 100%; }
            .download-sample-btn { width: 100%; justify-content: center; padding: 12px; font-size: 0.9rem; }
            .column-format { font-size: 0.85rem; padding: 10px; margin: 10px 0; overflow-x: auto; -webkit-overflow-scrolling: touch; }
            .upload-section { padding: 25px 12px; margin-bottom: 20px; }
            .btn-choose { width: 100%; max-width: 300px; justify-content: center; padding: 14px; font-size: 0.9rem; }
            .file-info { font-size: 0.85rem; width: 100%; }
            #divPreview { margin-top: 25px; padding: 12px; overflow-x: auto; -webkit-overflow-scrolling: touch; }
            #grdPreview { min-width: 800px; }
            #grdPreview th, #grdPreview td { padding: 8px 6px; font-size: 0.85rem; }
            .btn-action { width: 100%; margin-right: 0; margin-bottom: 10px; justify-content: center; padding: 14px; font-size: 0.9rem; }
        }

        @media (max-width: 575px) {
            .upload-container { padding: 10px; }
            .format-info { padding: 15px; border-width: 1px; }
            .format-info h3 { font-size: 0.95rem; }
            .format-info h3::before { width: 20px; height: 20px; line-height: 20px; font-size: 0.8rem; }
            .note-section { font-size: 0.85rem; }
            .column-format { font-size: 0.8rem; padding: 8px; }
            .upload-section { padding: 20px 10px; border-width: 1px; }
            .btn-choose { padding: 12px; font-size: 0.85rem; }
            .file-info { font-size: 0.8rem; }
            .loading-content { padding: 20px; width: 95%; }
            .loading-content h3 { font-size: 1rem; }
            .loading-content p { font-size: 0.9rem; }
            #grdPreview { min-width: 850px; }
            #grdPreview th { padding: 10px 6px; font-size: 0.8rem; }
            #grdPreview td { padding: 6px; font-size: 0.8rem; }
            #grdPreview .select-header, #grdPreview .select-cell { min-width: 60px; }
        }

        @media (max-width: 375px) {
            .upload-container { padding: 8px; }
            .format-info { padding: 12px; }
            .format-info h3 { font-size: 0.9rem; }
            .download-sample-btn { font-size: 0.85rem; padding: 10px; }
            .btn-choose { font-size: 0.85rem; padding: 10px 16px; }
            .btn-action { font-size: 0.85rem; padding: 12px; }
            .file-info { font-size: 0.75rem; }
        }

        @media (hover: none) and (pointer: coarse) {
            .btn-choose, .btn-action, .download-sample-btn { min-height: 44px; }
            #grdPreview input[type="checkbox"] { transform: scale(1.5); margin: 5px; }
            #grdPreview th, #grdPreview td { padding: 12px 8px; }
            .btn-choose, .btn-action, .download-sample-btn { user-select: none; -webkit-tap-highlight-color: transparent; }
            #divPreview, #grdPreview, .column-format { -webkit-overflow-scrolling: touch; scrollbar-width: thin; }
        }

        @media print {
            .upload-section, .btn-choose, .btn-action, .download-sample-btn, .loading-overlay { display: none !important; }
            .format-info { border: 1px solid #000; background: none; }
            #divPreview { border: none; background: none; }
            #grdPreview { border-collapse: collapse; }
            #grdPreview th { background-color: #fff !important; color: #000 !important; border: 1px solid #000; }
            #grdPreview td { border: 1px solid #000; }
        }
    </style>

    <div class="upload-container">

        <!-- Format Info -->
        <div class="format-info">
            <div class="format-header">
                <h3>Excel Format Required:</h3>
                <asp:LinkButton ID="lnkDownloadSample" runat="server"
                    CssClass="download-sample-btn"
                    OnClick="lnkDownloadSample_Click"
                    OnClientClick="return true;">
                    📥 Download Sample Excel
                </asp:LinkButton>
            </div>
            <p>Your Excel file should have the following columns in this exact order:</p>
            <div class="column-format">
                Quiz Name | Question | Option A | Option B | Option C | Option D | Correct Option | Marks
            </div>
            <div class="note-section">
                <strong>Note:</strong> First row should be headers, data starts from row 2<br />
                <strong>Quiz Name:</strong> Enter the exact quiz name (case-insensitive). If quiz doesn't exist, question will be skipped.
            </div>
        </div>

        <!-- Upload Section -->
        <div class="upload-section">
            <asp:FileUpload ID="fileUploadExcel" runat="server"
                accept=".xlsx"
                style="display: none;"
                onchange="handleFileSelect(this)" />

            <button type="button" class="btn-choose"
                onclick="document.getElementById('<%=fileUploadExcel.ClientID%>').click();">
                📂 Choose File
            </button>

            <div class="file-info">
                ✓ Supported format: .xlsx only<br />
                ⚠ Maximum file size: 5 MB
            </div>
        </div>

        <!-- Hidden Upload Button -->
        <asp:Button ID="btnUploadHidden" runat="server"
            OnClick="btnUpload_Click"
            style="display: none;"
            UseSubmitBehavior="true" />

        <!-- Loading Overlay -->
        <div class="loading-overlay" id="loadingOverlay">
            <div class="loading-content">
                <div class="spinner"></div>
                <h3>Uploading and Processing File...</h3>
                <p>Please wait while we process your Excel file</p>
            </div>
        </div>

    </div>

    <script>
        function handleFileSelect(input) {
            if (input.files && input.files[0]) {
                var file = input.files[0];
                var ext = file.name.split('.').pop().toLowerCase();

                if (ext !== 'xlsx') {
                    Swal.fire('Invalid File', 'Only .xlsx files are supported.', 'error');
                    input.value = '';
                    return;
                }

                if (file.size > 5242880) {
                    Swal.fire('File Too Large', 'Maximum file size is 5 MB', 'error');
                    input.value = '';
                    return;
                }

                if (file.size < 100) {
                    Swal.fire('Invalid File', 'File appears to be empty or too small.', 'error');
                    input.value = '';
                    return;
                }

                // Show loading then submit the whole form
                document.getElementById('loadingOverlay').style.display = 'flex';
                setTimeout(function () {
                    // Find the form and submit it via the upload button
                    var btn = document.getElementById('<%=btnUploadHidden.ClientID%>');
                    btn.click();
                }, 200);
            }
        }
    </script>
</asp:Content>