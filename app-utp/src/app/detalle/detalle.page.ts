import { Component } from '@angular/core';
import { ActivatedRoute,RouterModule } from '@angular/router';
import { IonicModule } from '@ionic/angular';
import { CommonModule } from '@angular/common';
import { ResumenAppComponent } from '../components/resumen-app/resumen-app.component';
import { SelectorTipoComponent } from '../components/selector-tipo/selector-tipo.component';
@Component({
  selector: 'app-detalle',
  standalone: true,
  imports: [IonicModule, CommonModule,RouterModule,ResumenAppComponent,SelectorTipoComponent],
  templateUrl: './detalle.page.html',
  styleUrls: ['./detalle.page.scss']
})
export class DetallePage {
  tipoApp = 'Sin tipo seleccionado';
  constructor(private route: ActivatedRoute) {
    this.route.queryParams.subscribe(params => {
      this.tipoApp = params['tipoApp'] || 'Sin tipo seleccionado';
    });
  }
  actualizarTipo(nuevoTipo: string){
    this.tipoApp=nuevoTipo
  }
}