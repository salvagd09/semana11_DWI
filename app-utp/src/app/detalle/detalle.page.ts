import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-detalle',
  templateUrl: './detalle.page.html',
  styleUrls: ['./detalle.page.scss'],
})
export class DetallePage {
  tipo = '';
  constructor(private route: ActivatedRoute) {
    this.route.queryParams.subscribe(params => {
      this.tipo = params['tipo'] || 'Sin tipo seleccionado';
    });
  }
}
