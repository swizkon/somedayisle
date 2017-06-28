import $ from "jquery"

let circuit = {
    do: function () {
        alert('do' + arguments[0])
    },

    renderPreviews: function () {
        $('canvas.circuit-checkpoints').each((i, m) => {
            var points = $(m).data('checkpoints');
            var scale = parseInt($(m).data('scale'));
            points = $.map(points, (o, i) => {
                    return {
                        x: o[0] * scale,
                        y: o[1] * scale
                    }
            });
            circuit.drawPreview(m, points, scale);
        });
    },

    drawPreview: function (canvas, points, scale) {
        var context = canvas.getContext("2d");
        context.clearRect(0, 0, canvas.width, canvas.height);
        context.translate(0.0, 0.0);
        
        circuit.drawPath(context, 80 / scale, "#999", points);
        circuit.drawPath(context, 60 / scale, "#ccc", points);
    },

    drawPath: function(context, lineWidth, color, points){
        context.lineWidth = lineWidth;
        context.strokeStyle = color;
        context.beginPath();
        context.moveTo(points[0].x, points[0].y);
        var pointIndex;
        for (pointIndex = 0; pointIndex < points.length; pointIndex++) {
            context.lineTo(points[pointIndex].x, points[pointIndex].y);
        }
        context.closePath();
        context.lineJoin = 'round';
        context.stroke();
    }
}

$(document).ready(function () {
    circuit.renderPreviews();
});

export default circuit