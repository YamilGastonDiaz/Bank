<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="fragmentos/VerificarSesion.jspf"%>

<html>
<head>
<meta charset="UTF-8">
<title>Reportes</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
<link rel="icon" href="assets/bank.png" type="image/png" />

<style>
    .report-btn-primary, .report-btn-secondary {
        color: white;
        padding: 0.5rem 1.5rem;
        border-radius: 0.375rem;
        font-weight: 600;
        transition: background-color 0.2s ease-in-out;
        display: inline-flex;
        justify-content: center;
        align-items: center;
        border: none;
    }
    .report-btn-primary { background-color: #3B82F6; }
    .report-btn-primary:hover { background-color: #2563EB; }
    .report-btn-secondary { background-color: #6B7280; }
    .report-btn-secondary:hover { background-color: #4B5563; }
    .report-error-message { color: #EF4444; font-size: 0.875rem; margin-top: 0.5rem; }
    .report-bg-primary { background-color: #3B82F6 !important; color: white !important; }
    .report-bg-success { background-color: #22C55E !important; color: white !important; }
    .report-bg-warning { background-color: #FBBF24 !important; color: white !important; }
    .report-bg-danger { background-color: #EF4444 !important; color: white !important; }
    .report-card { border-radius: 0.5rem; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); border: 1px solid rgba(0,0,0,0.1); }
    .report-card-header { padding: 1rem 1.5rem; border-bottom: 1px solid rgba(0,0,0,0.1); font-weight: 600; background-color: rgba(0,0,0,0.03); }
    .report-card-body { padding: 1.5rem; }
</style>
</head>
<body>
<jsp:include page="Nav.jsp" />

<div class="container mt-4">
    <div class="text-center mb-4">
        <h1 class="text-primary fw-semibold fs-3">Reportes</h1>
    </div>
    <form action="ReportesServlet" method="POST" id="filterForm">
        <%String fechaInicio = (String) request.getAttribute("fechaInicio"); %>
        <%String fechaHasta = (String) request.getAttribute("fechaHasta"); %>
        <div class="card p-4 mb-4">
            <div class="row align-items-end">
                <div class="col-md-4 mb-3">
                    <label for="IdfechaInicio" class="form-label fw-bold">Fecha desde:</label>
                    <input type="date" class="form-control" id="IdfechaInicio" name="fechaInicio" value="<%= fechaInicio != null ? fechaInicio : "" %>">
                </div>
                <div class="col-md-4 mb-3">
                    <label for="IdfechaHasta" class="form-label fw-bold">Fecha hasta:</label>
                    <input type="date" class="form-control" id="IdfechaHasta" name="fechaHasta" value="<%= fechaHasta != null ? fechaHasta : "" %>">
                </div>
                <div class="col-md-4 mb-3">
                    <div class="d-flex gap-2">
                        <button type="submit" name="btnfiltrar" class="report-btn-primary w-100">Filtrar</button>
                        <button type="submit" name="btnLimpiar" class="report-btn-secondary w-100">Limpiar</button>
                    </div>
                </div>
            </div>
            <%boolean verificarInput = (boolean) request.getAttribute("VerificarImput"); 
            if(!verificarInput) { %>
                <div class="report-error-message">"Verifique las fechas ingresadas"</div>
            <% } %>
        </div>
    </form>

    <%int cuentasActivas = (int) request.getAttribute("cuentasActivas"); %>	    	
	<%float porcCuentasActivas = (float) request.getAttribute("porcCuentasActivas"); %>
	<%float porcCuentasInactivas = (float) request.getAttribute("porcCuentasInactivas"); %>
	<%int cuentasInactivadas =  (int) request.getAttribute("cuentasInactivadas");%>
	<%int clientesActivos = (int) request.getAttribute("clientesActivos"); %>
	<%int cuentasActivadas = (int) request.getAttribute("cuentasActivadas"); %>
			
	<%float PorcPrestAprobados = (float) request.getAttribute("PorcPrestAprobados"); %>
	<%float PorcPrestRechazados = (float) request.getAttribute("PorcPrestRechazados"); %>
	<%String gananciaPrestamosString = (String) request.getAttribute("gananciaPrestamosString"); %>
	<%int PrestAprobados = (int) request.getAttribute("PrestAprobados"); %>
	<%int totalPrestamos = (int) request.getAttribute("totalPrestamos"); %>
	



    <div class="row">
        <div class="col-md-3 mb-4">
            <div class="report-card report-bg-primary">
                <div class="report-card-header">Clientes Actuales</div>
                <div class="report-card-body">
                    <h5 class="fs-4 fw-bold"><%= clientesActivos %></h5>
                    <p>Total de clientes actuales.</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-4">
            <div class="report-card report-bg-success">
                <div class="report-card-header">Cuentas Activas</div>
                <div class="report-card-body">
                    <h5 class="fs-4 fw-bold"><%= cuentasActivas %></h5>
                    <p>Total de cuentas activas.</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-4">
            <div class="report-card report-bg-warning">
                <div class="report-card-header">Cuentas activadas</div>
                <div class="report-card-body">
                    <h5 class="fs-4 fw-bold"><%= cuentasActivadas %></h5>
                    <p>Total periodo seleccionado.</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-4">
            <div class="report-card report-bg-danger">
                <div class="report-card-header">Cuentas desactivadas</div>
                <div class="report-card-body">
                    <h5 class="fs-4 fw-bold"><%= cuentasInactivadas %></h5>
                    <p>Total periodo seleccionado.</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12 mb-4">
            <div class="report-card">
                <div class="report-card-header">Prestamos solicitados</div>
                <div class="report-card-body">
                    <canvas id="barChart"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-6 mb-4">
            <div class="report-card h-100">
                <div class="report-card-header">Porcentaje de Cuentas (Activas/Inactivas)</div>
                <div class="report-card-body">
                    <canvas id="pieChart"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-6 mb-4">
            <div class="report-card h-100">
                <div class="report-card-header">Porcentaje de Préstamos (Aprobados/Rechazados)</div>
                <div class="report-card-body">
                    <canvas id="pieChart2"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="Footer.html" />
<%int[] meses = (int[]) request.getAttribute("meses"); %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
<script>
    
    Chart.register(ChartDataLabels);

    var ctxBar = document.getElementById('barChart').getContext('2d');
    var barChart = new Chart(ctxBar, {
        type: 'bar',
        data: {
            labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
            datasets: [{
            	label: 'Aprobados: <%= PrestAprobados %> / <%= totalPrestamos %> solicitudes - Ganancia obtenida de intereses $ <%= gananciaPrestamosString %>',
                data: [<%=meses[0]%>, <%=meses[1]%>, <%=meses[2]%>, <%=meses[3]%>, <%=meses[4]%>, <%=meses[5]%>, <%=meses[6]%>, <%=meses[7]%>, <%=meses[8]%>, <%=meses[9]%>, <%=meses[10]%>, <%=meses[11]%>],
                backgroundColor: 'rgba(54, 162, 235, 0.5)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            
            plugins: {
                datalabels: {
                	anchor: 'Center', 
                    align: 'Center',    
                    formatter: function(value, context) {
                        return value; 
                    },
                    color: '#444', 
                    font: {
                        weight: 'bold', 
                        size: 12        
                    }
                }
            }
            
        }
    });

 
    var ctxPie = document.getElementById('pieChart').getContext('2d');
    var pieChart = new Chart(ctxPie, {
        type: 'pie',
        data: {
            labels: ['Cuentas Activadas', 'Cuentas Inactivadas'],
            datasets: [{
                data: [<%=porcCuentasActivas%>, <%=porcCuentasInactivas%>],
                backgroundColor: ['#76d7c4', '#f1948a']
            }]
        },
        options: {
            responsive: true,
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.label || '';

                            if (label) {
                                label += ': ';
                            }
                            if (context.parsed !== null) {
                                label += context.parsed.toFixed(2) + '%';
                            }
                            return label;
                        }
                    }
                },
                
                datalabels: {
                    formatter: (value, ctx) => {
                        let sum = 0;
                        let dataArr = ctx.chart.data.datasets[0].data;
                        dataArr.map(data => {
                            sum += data;
                        });
                        let percentage = (value * 100 / sum).toFixed(2) + "%";
                        return percentage;
                    },
                    color: '#fff', 
                    font: {
                        weight: 'bold',
                        size: 14
                    }
                }
            }
        }
    });

    

    var ctxPie2 = document.getElementById('pieChart2').getContext('2d');
    var pieChart2 = new Chart(ctxPie2, { 
        type: 'pie',
        data: {
            labels: ['Aprobados', 'Rechazados'],
            datasets: [{
                data: [<%= PorcPrestAprobados%>, <%= PorcPrestRechazados%>], 
                backgroundColor: ['#85c1e9', '#8e44ad']
            }]
        },
        options: {
            responsive: true,
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.label || '';

                            if (label) {
                                label += ': ';
                            }
                            if (context.parsed !== null) {
                                label += context.parsed.toFixed(2) + '%';
                            }
                            return label;
                        }
                    }
                },
                datalabels: {
                    formatter: (value, ctx) => {
                        let sum = 0;
                        let dataArr = ctx.chart.data.datasets[0].data;
                        dataArr.map(data => {
                            sum += data;
                        });
                        let percentage = (value * 100 / sum).toFixed(2) + "%";
                        return percentage;
                    },
                    color: '#fff',
                    font: {
                        weight: 'bold',
                        size: 14
                    }
                }
            }
        }
    });
</script>

</body>
</html>
