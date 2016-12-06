import Piece from './piece'

class NullPiece extends Piece {
	constructor() {
		super();
		this.color = null;
	}

	toString() {
		return " ";
	}
}

let p = new NullPiece;
console.log(p.color);

export default Piece;
