import { Component, Input } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { CommonModule } from '@angular/common';
@Component({
  selector: 'app-resumen-app',
  standalone: true,
  imports: [IonicModule, CommonModule],
  templateUrl: './resumen-app.component.html',
  styleUrls: ['./resumen-app.component.scss']
})
export class ResumenAppComponent {
  @Input() tipo = '';
}
