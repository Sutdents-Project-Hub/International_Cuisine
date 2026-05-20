import {
  Controller,
  Get,
  Post,
  Patch,
  Delete,
  Param,
  Body,
  UseGuards,
  Request,
  Res,
  Header,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
} from '@nestjs/swagger';
import type { Response } from 'express';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { ShoppingListsService } from './shopping-lists.service';
import { CreateShoppingListDto } from './dto/create-shopping-list.dto';
import type { AuthenticatedRequest } from '../auth/auth.types';

@ApiTags('Shopping Lists')
@Controller('shopping-lists')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
export class ShoppingListsController {
  constructor(private readonly shoppingListsService: ShoppingListsService) {}

  @Get()
  @ApiOperation({ summary: 'List all shopping lists' })
  @ApiResponse({ status: 200, description: 'User shopping lists' })
  findAll(@Request() req: AuthenticatedRequest) {
    return this.shoppingListsService.findAll(req.user.id);
  }

  @Post()
  @ApiOperation({
    summary:
      'Create shopping list from recipe IDs with servings (auto-merges ingredients)',
  })
  @ApiResponse({
    status: 201,
    description: 'Shopping list created with merged ingredients',
  })
  create(
    @Request() req: AuthenticatedRequest,
    @Body() dto: CreateShoppingListDto,
  ) {
    return this.shoppingListsService.create(req.user.id, dto);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get shopping list detail' })
  @ApiResponse({ status: 200, description: 'Shopping list with items' })
  findOne(@Request() req: AuthenticatedRequest, @Param('id') id: string) {
    return this.shoppingListsService.findOne(req.user.id, id);
  }

  @Patch(':id/items/:itemId/toggle')
  @ApiOperation({ summary: 'Toggle item checked status' })
  @ApiResponse({ status: 200, description: 'Item toggled' })
  toggleItem(
    @Request() req: AuthenticatedRequest,
    @Param('id') id: string,
    @Param('itemId') itemId: string,
  ) {
    return this.shoppingListsService.toggleItem(req.user.id, id, itemId);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a shopping list' })
  @ApiResponse({ status: 200, description: 'Shopping list deleted' })
  remove(@Request() req: AuthenticatedRequest, @Param('id') id: string) {
    return this.shoppingListsService.remove(req.user.id, id);
  }

  @Get(':id/export')
  @ApiOperation({ summary: 'Export shopping list as CSV' })
  @ApiResponse({ status: 200, description: 'CSV file download' })
  @Header('Content-Type', 'text/csv')
  async exportCsv(
    @Request() req: AuthenticatedRequest,
    @Param('id') id: string,
    @Res() res: Response,
  ) {
    const csv = await this.shoppingListsService.exportCsv(req.user.id, id);
    res.setHeader(
      'Content-Disposition',
      `attachment; filename="shopping-list-${id}.csv"`,
    );
    res.send(csv);
  }
}
